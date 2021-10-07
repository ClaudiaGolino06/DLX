library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.myTypes.all;
--use ieee.numeric_std.all;
--use work.all;

entity dlx_cu is
  generic (
    MICROCODE_MEM_SIZE :     integer := MEM_SIZE;  -- Microcode Memory Size
    FUNC_SIZE          :     integer := 11;  -- Func Field Size for R-Type Ops
    OP_CODE_SIZE       :     integer := 6;  -- Op Code Size
    -- ALU_OPC_SIZE       :     integer := 6;  -- ALU Op Code Word Size
    IR_SIZE            :     integer := 32;  -- Instruction Register Size    
    CW_SIZE            :     integer := 15);  -- Control Word Size
  port (
    Clk                : in  std_logic;  -- Clock
    Rst                : in  std_logic;  -- Reset:Active-Low
    -- Instruction Register
    IR_IN              : in  std_logic_vector(IR_SIZE - 1 downto 0);
    
    -- IF Control Signal
    IR_LATCH_EN        : out std_logic;  -- Instruction Register Latch Enable
    NPC_LATCH_EN       : out std_logic;
                                        -- NextProgramCounter Register Latch Enable
    -- ID Control Signals
    RegA_LATCH_EN      : out std_logic;  -- Register A Latch Enable
    RegB_LATCH_EN      : out std_logic;  -- Register B Latch Enable
    RegIMM_LATCH_EN    : out std_logic;  -- Immediate Register Latch Enable

    -- EX Control Signals
    MUXA_SEL           : out std_logic;  -- MUX-A Sel
    MUXB_SEL           : out std_logic;  -- MUX-B Sel
    ALU_OUTREG_EN      : out std_logic;  -- ALU Output Register Enable
    EQ_COND            : out std_logic;  -- Branch if (not) Equal to Zero
    -- ALU Operation Code
    ALU_OPCODE         : out aluOp; -- choose between implicit or exlicit coding, like std_logic_vector(ALU_OPC_SIZE -1 downto 0);
    
	signed_unsigned		: out std_logic;
    
    -- MEM Control Signals
    DRAM_WE            : out std_logic;  -- Data RAM Write Enable
    LMD_LATCH_EN       : out std_logic;  -- LMD Register Latch Enable
    JUMP_EN            : out std_logic;  -- JUMP Enable Signal for PC input MUX
    PC_LATCH_EN        : out std_logic;  -- Program Counte Latch Enable

    -- WB Control signals
    WB_MUX_SEL         : out std_logic;  -- Write Back MUX Sel
    RF_WE              : out std_logic;
    
    -----
    lhi_sel: out	std_logic;
    sb_op: out	std_logic
    );  -- Register File Write Enable
	
	
-- muxA 0 = regA
-- muxA 1 = NPC
-- muxB 0 = regB
-- muxB 1 = immediato
	
end dlx_cu;

architecture dlx_cu_hw of dlx_cu is
  type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE- 1) of std_logic_vector(CW_SIZE - 1 downto 0);
  signal cw_mem : mem_array := ("111100010000111", -- R type: IS IT CORRECT?
                                "000000000000000", 
                                "111010111001100", -- J (0X02) instruction encoding corresponds to the address to this ROM
                                "111010111001111", -- JAL to be filled          
                                "110011110000100", -- BEQZ to be filled
                                "110011111000100", -- BNEZ                         
                                "000000000000000",  -- we do not implement the bfpt instruction so we use this for the stall
                                "000000000000000",
                                "111010110000111", -- ADD i (0X08): FILL IT!!!
                                "111010110000111", -- ADDUI       unsigned
                                "111010110000111", --SUBI (10)
                                "111010110000111",  --SUBUI      unsigned
                                "111010110000111", --ANDI (12)   unsigned
                                "111010110000111", --ORI (13)
                                "111010110000111", --xori (14)
                                "110010110000111", --LHI
                                "000000000000000",
                                "000000000000000",
                                "111010101001100", --JR
                                "111010101001111", --JALR          
                                "111010110000111", --SLLI (20)
                                "110000000000100", --NOP (21)
                                "111010110000111", --SRLI (22)
                                "111010110000111", --SRAI ---
                                "111010110000111", --SEQI
                                "111010110000111",--SNEI (25)     
                                "111010110000111", --SLTI
                                "111010110000111", --SGTI
                                "111010110000111", --SLEI (28)  -
                                "111010110000111", --SGEI (29)  
                                "000000000000000",
                                "000000000000000",
                                "111010110010101", --LB
                                "000000000000000",
                                "000000000000000",
                                "111010110010101", --LW (35)  
                                "111010110010101", --LBU
                                "111010110010101", --LHU
                                "000000000000000",
                                "000000000000000",
                                "111110110110100", --SB
                                "000000000000000",
                                "000000000000000",
                                "111110110110100",--SW (43)
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "000000000000000",
                                "111010110000111",--SLTUI
                                "111010110000111",--SGTUI
                                "000000000000000",
                                "111010110000111");    --SGEUI                         
                                
  signal IR_opcode : std_logic_vector(OP_CODE_SIZE -1 downto 0);  -- OpCode part of IR
  signal IR_func : std_logic_vector(FUNC_SIZE-1 downto 0);   -- Func part of IR when Rtype
  signal cw   : std_logic_vector(CW_SIZE - 1 downto 0); -- full control word read from cw_mem


  -- control word is shifted to the correct stage
  signal cw1 : std_logic_vector(CW_SIZE -1 downto 0); -- first stage
  signal cw2 : std_logic_vector(CW_SIZE - 1 - 2 downto 0); -- second stage
  signal cw3 : std_logic_vector(CW_SIZE - 1 - 5 downto 0); -- third stage
  signal cw4 : std_logic_vector(CW_SIZE - 1 - 9 downto 0); -- fourth stage
  signal cw5 : std_logic_vector(CW_SIZE -1 - 13 downto 0); -- fifth stage

  signal aluOpcode_i: aluOp := NOP; -- ALUOP defined in package
  signal aluOpcode1: aluOp := NOP;
  signal aluOpcode2: aluOp := NOP;
  signal aluOpcode3: aluOp := NOP;


  signal signed_unsigned_i: std_logic := '0'; -- this signal is to said to the datapath if the operation is unsigned
  signal signed_unsigned_1: std_logic := '0';  -- this signal is to said to the datapath if the operation is unsigned
  signal signed_unsigned_2: std_logic := '0';  -- this signal is to said to the datapath if the operation is unsigned
  signal signed_unsigned_3: std_logic := '0';  -- this signal is to said to the datapath if the operation is unsigned
  signal jump: std_logic := '0';				--if the operation is a jump this is set to 1
  signal lhi_sel_i: std_logic :='0';
  signal sb_op_i: std_logic :='0';
begin  -- dlx_cu_rtl

  IR_opcode(5 downto 0) <= IR_IN(31 downto 26);
  IR_func(10 downto 0)  <= IR_IN(FUNC_SIZE - 1 downto 0);
	
	cw <= cw_mem(conv_integer(unsigned(IR_opcode)));
  -- stage one control signals
  IR_LATCH_EN  <= cw1(CW_SIZE - 1);
  NPC_LATCH_EN <= cw1(CW_SIZE - 2);
  
  -- stage two control signals
  RegA_LATCH_EN   <= cw2(CW_SIZE - 3);
  RegB_LATCH_EN   <= cw2(CW_SIZE - 4);
  RegIMM_LATCH_EN <= cw2(CW_SIZE - 5);
  
  -- stage three control signals
  MUXA_SEL      <= cw3(CW_SIZE - 6);
  MUXB_SEL      <= cw3(CW_SIZE - 7);
  ALU_OUTREG_EN <= cw3(CW_SIZE - 8);
  EQ_COND       <= cw3(CW_SIZE - 9);
  
  -- stage four control signals
  DRAM_WE      <= cw4(CW_SIZE - 10);
  LMD_LATCH_EN <= cw4(CW_SIZE - 11);
  JUMP_EN      <= cw4(CW_SIZE - 12);
  PC_LATCH_EN  <= cw4(CW_SIZE - 13);
  
  -- stage five control signals
  WB_MUX_SEL <= cw5(CW_SIZE - 14);
  RF_WE      <= cw5(CW_SIZE - 15);
 
  -- process to pipeline control words
  CW_PIPE: process (Clk, Rst)
   variable iterator : integer := 0;
   variable iterator1 : integer := 0;
   variable iterator2 : integer := 0;
  begin  -- process Clk
    if Rst = '0' then                   -- asynchronous reset (active low)
      cw1 <= (others => '0');
      cw2 <= (others => '0');
      cw3 <= (others => '0');
      cw4 <= (others => '0');
      cw5 <= (others => '0');
      aluOpcode1 <= NOP;
      aluOpcode2 <= NOP;
      aluOpcode3 <= NOP;
    elsif Clk'event and Clk = '1' then  -- rising clock edge
		 cw1 <= cw;
	  
-----------------------------------------------------------------------------	  
	  if lhi_sel_i='1' then
		iterator1 :=iterator1+1;
		lhi_sel <= '0';
		if iterator1 = 3 then
			iterator1 :=0;
			lhi_sel_i <='0';
			lhi_sel <= '1';
		end if;
	  else
		lhi_sel <= '0';
	  end if;
	  
	  if sb_op_i='1' then
		iterator2 :=iterator2+1;
		sb_op <= '1';
		if iterator2 = 4 then
			iterator2 :=0;
			sb_op_i <='0';
			sb_op <= '1';
		end if;
	  else
		sb_op <= '0';
	  end if;
-----------------------------------------------------------------------------
	  
	  cw2 <= cw1(CW_SIZE - 1 - 2 downto 0);
      cw3 <= cw2(CW_SIZE - 1 - 5 downto 0);
      cw4 <= cw3(CW_SIZE - 1 - 9 downto 0);
      cw5 <= cw4(CW_SIZE -1 - 13 downto 0);
	  
	  
		aluOpcode1 <= aluOpcode_i;
		aluOpcode2 <= aluOpcode1;
		aluOpcode3 <= aluOpcode2;
      
		signed_unsigned_1 <= signed_unsigned_i;
		signed_unsigned_2 <= signed_unsigned_1;
		--signed_unsigned_3 <= signed_unsigned_2;
    end if;
  end process CW_PIPE;
  signed_unsigned <=signed_unsigned_2;
  ALU_OPCODE <= aluOpcode3;

 -- purpose: Generation of ALU_OpCode
  --type   : combinational
  --inputs : IR_i
  --outputs: aluOpcode
   ALU_OP_CODE_P : process (IR_opcode, IR_func)
   begin  -- process ALU_OP_CODE_P
	case conv_integer(unsigned(IR_opcode)) is
	        -- case of R type requires analysis of FUNC
		when 0 =>
			case conv_integer(unsigned(IR_func)) is
				when 4 => aluOpcode_i <= LLS; -- sll according to instruction set coding
							signed_unsigned_i<='1';
				when 6 => aluOpcode_i <= LRS; -- srl
							signed_unsigned_i<='1';
				when 7 => aluOpcode_i <= SRA1; -- SRA
							signed_unsigned_i<='0';
				when 32 => aluOpcode_i <= ADD; -- ADD
							signed_unsigned_i<='0';
				when 33 => aluOpcode_i <= ADDU; -- ADDU
							signed_unsigned_i<='1';
				when 34 => aluOpcode_i <= SUB; -- SUB
							signed_unsigned_i<='0';
				when 35 => aluOpcode_i <= SUBU; -- SUBU
							signed_unsigned_i<='1';
				when 36 => aluOpcode_i <= ANDR; -- AND
							signed_unsigned_i<='1';
				when 37 => aluOpcode_i <= ORR; -- OR
							signed_unsigned_i<='1';
				when 38 => aluOpcode_i <= XORR; -- XOR
							signed_unsigned_i<='1';
				when 40 => aluOpcode_i <= SEQ; -- SEQ
							signed_unsigned_i<='0';
				when 41 => aluOpcode_i <= SNE; -- SNE
							signed_unsigned_i<='0';
				when 42 => aluOpcode_i <= SLT; -- SLT
							signed_unsigned_i<='0';
				when 43 => aluOpcode_i <= SGT; -- SGT
							signed_unsigned_i<='0';
				when 44 => aluOpcode_i <= SLE; -- SLE
							signed_unsigned_i<='0';
				when 45 => aluOpcode_i <= SGE; -- SGE
							signed_unsigned_i<='0';
				when 58 => aluOpcode_i <= SLTU; -- SLTU
							signed_unsigned_i<='1';
				when 59 => aluOpcode_i <= SGTU; -- SGTU
							signed_unsigned_i<='1';
				when 61 => aluOpcode_i <= SGEU; -- SGEU
							signed_unsigned_i<='1';
				when others => aluOpcode_i <= NOP;
			end case;
		when 2 => aluOpcode_i <= NOP; -- j
				jump <='1';
				signed_unsigned_i<='0';
		when 3 => aluOpcode_i <= NOP; -- jal
				jump <='1';
				signed_unsigned_i<='0';
		when 4 => aluOpcode_i <= BEQZ; --beqz
				jump <='1';
				signed_unsigned_i<='0';
		when 5 => aluOpcode_i <= BNEZ; --BNEZ
				jump <='1';
				signed_unsigned_i<='0';
		when 8 => aluOpcode_i <= ADDS; -- addi
				signed_unsigned_i<='0';
		when 9 => aluOpcode_i <= ADDUI; -- addUi
				signed_unsigned_i<='1';
		when 10 => aluOpcode_i <= SUBI; --SUBI
				signed_unsigned_i<='0';
		when 11 => aluOpcode_i <= SUBUI; --SUBUI
				signed_unsigned_i<='1';
		when 12 => aluOpcode_i <= ANDI; --ANDI
				signed_unsigned_i<='1';
		when 13 => aluOpcode_i <= ORI; --ORI
				signed_unsigned_i<='1';
		when 14 => aluOpcode_i <= XORI; --XORI
				signed_unsigned_i<='1';
		when 15 => aluOpcode_i <= NOP; --LHI,it loads only a value in the register so it has not to perform any operation
				signed_unsigned_i<='0';
				 lhi_sel_i<='1';
		when 18 => aluOpcode_i <= NOP; --jr
				jump <='1';
				signed_unsigned_i<='1';
		when 19 => aluOpcode_i <= NOP; --JALR
				jump <='1';
				signed_unsigned_i<='0';
		when 20 => aluOpcode_i <= SLLI; --SLLI
				signed_unsigned_i<='1';
		when 21 => aluOpcode_i <= NOP; --NOP
				signed_unsigned_i<='0';
		when 22 => aluOpcode_i <= SRLI; --SRLI
				signed_unsigned_i<='1';
		when 23 => aluOpcode_i <= SRAI; --SRAI
				signed_unsigned_i<='0';
		when 24 => aluOpcode_i <= SEQI; --SEQI
				signed_unsigned_i<='0';		
		when 25 => aluOpcode_i <= SNEI; --SNEI
				signed_unsigned_i<='0';
		when 26 => aluOpcode_i <= SLTI; --SLTI
				signed_unsigned_i<='0';
		when 27 => aluOpcode_i <= SGTI; --SGTI
				signed_unsigned_i<='0';		
		when 28 => aluOpcode_i <= SLEI; --SLEI
				signed_unsigned_i<='0';
		when 29 => aluOpcode_i <= SGEI; --SGEI
				signed_unsigned_i<='0';
		when 32 => aluOpcode_i <= LB; --LB
				signed_unsigned_i<='0';
		when 35 => aluOpcode_i <= LW; --LW
				signed_unsigned_i<='1';
		when 36 => aluOpcode_i <= LBU; --LBU
				signed_unsigned_i<='0';
		when 37 => aluOpcode_i <= LHU; --LHU
				signed_unsigned_i<='0';
		when 40 => aluOpcode_i <= SB; --SB
				signed_unsigned_i<='0';		
				sb_op_i<='1';
		when 43 => aluOpcode_i <= SW; --SW
				signed_unsigned_i<='1';
		when 58 => aluOpcode_i <= SLTUI; --SLTUI
				signed_unsigned_i<='1';
		when 59 => aluOpcode_i <= SGTUI; --SGTUI
				signed_unsigned_i<='1';
		when 61 => aluOpcode_i <= SGEUI; --SGEUI
				signed_unsigned_i<='1';
		when others => aluOpcode_i <= NOP;
	 end case;
	end process ALU_OP_CODE_P;

end dlx_cu_hw;
