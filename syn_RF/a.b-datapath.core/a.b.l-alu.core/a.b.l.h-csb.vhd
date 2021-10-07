library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use WORK.constants.all;


--NumBitBlock=4


entity CSB is   
	generic (NBIT : integer := N_PER_BLOCK);
	Port (	A:	In	std_logic_vector(NBIT-1 downto 0); 
		B:	In	std_logic_vector(NBIT-1 downto 0); 
		Ci:	In	std_logic; 			 			  -- mux select
		S:	Out	std_logic_vector(NBIT-1 downto 0)); 		   
end CSB; 

architecture STRUCTURAL of CSB is
signal out_rca0, out_rca1:	std_logic_vector(NBIT-1 downto 0);

component RCA is   
	generic (NBIT : integer:=N_PER_BLOCK);
	Port (	A:	In	std_logic_vector(NBIT-1 downto 0);
		B:	In	std_logic_vector(NBIT-1 downto 0);
		Ci:	In	std_logic;
		S:	Out	std_logic_vector(NBIT-1 downto 0);
		Co:	Out	std_logic);
end component; 

component MUX21_GENERIC is
	generic (NBIT: integer:=N_PER_BLOCK);
	Port (	A:	In	std_logic_vector(NBIT-1 DOWNTO 0);
		B:	In	std_logic_vector(NBIT-1 DOWNTO 0);
		SEL:	In	std_logic;
		Y:	Out	std_logic_vector(NBIT-1 DOWNTO 0));
end component;

begin

  
    RCA0 : RCA 
	Port Map (A, B, '0', out_rca0);  

    RCA1 : RCA 
	Port Map (A, B,'1', out_rca1); 	
	
    MUXCin: MUX21_GENERIC 
	Port Map (out_rca1, out_rca0, Ci, S);

end STRUCTURAL;



configuration CFG_CSB_STRUCTURAL of CSB is
  for STRUCTURAL 
    for all: MUX21_GENERIC
        use configuration WORK.CFG_MUX21_GEN_STRUCTURAL;
      end for;
    for all: RCA
        use configuration WORK.CFG_RCA_STRUCTURAL;
      end for;

  end for;
end CFG_CSB_STRUCTURAL;

