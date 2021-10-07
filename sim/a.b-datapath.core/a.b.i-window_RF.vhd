library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.myTypes.all;

--M= #GLOBAL_REGS=8
--N= #LOCAL/IN/OUT_REGS=8
--F= #WINDOWS=5
entity windRF is
 generic(
		M:	integer:=num_global_regs;
		N:	integer:=num_local_inout_regs;
		F:	integer:=num_windows;
		NBIT:	integer:=Numbit);
 port ( CLK: 		IN std_logic; 
        RESET:	 	IN std_logic; --ACTIVE LOW synchronous
		ENABLE: 	IN std_logic; --active high
		CALL: 		IN std_logic; --control signal(==cs) to subroutine calls (active high)
		RETRN: 		IN std_logic; --cs to subroutine callbacks (active high)
		FILL:	 	OUT std_logic; -- cs to retrieve data from memory (active high)
		SPILL: 		OUT std_logic; --cs to put data in the mem (active high)
		BUSin: 		IN std_logic_vector(NBIT-1 downto 0); --for fill data from mem
		BUSout: 	OUT std_logic_vector(NBIT-1 downto 0); -- for spill data to mem
		RD1: 		IN std_logic; --cs for read port (active high)
		RD2: 		IN std_logic;
		WR: 		IN std_logic; --cs for write port (active high)
		ADD_WR: 	IN std_logic_vector(virt_addr-1 downto 0); --address of write port
		ADD_RD1: 	IN std_logic_vector(virt_addr-1 downto 0); --address of read port
		ADD_RD2: 	IN std_logic_vector(virt_addr-1 downto 0);
		DATAIN: 	IN std_logic_vector(NBIT-1 downto 0); 	--write port
		OUT1: 		OUT std_logic_vector(NBIT-1 downto 0); 	--read port
		OUT2: 		OUT std_logic_vector(NBIT-1 downto 0);
		wr_signal:  IN std_logic
);
end windRF;


--call&return cs cannot be raised at same cc: one instruction per clock in microprocessor

architecture bhv of windRF is
--External pov: RF is always N*3+M wide --> FULL RF: CWP(i+1)>N*3+M  (do SPILL) 
-->physical RF length= M+2*N*F, M globals+N_locals*F_wind+N_inout*F_wind
--> circular buffer length=2*N*F, not considered M globals
-->when you shift CWP: CWP(i+1)= CWP(i)+N*2;
-->switch SWP: SWP(i+1)= SWP(i)+N*2; (IN&local)== do a shift left of 1 position: N&'0' 

-- suggested structures
    subtype REG_ADDR is natural range 0 to phy_lenght-1; -- using natural type
type REG_ARRAY is array(REG_ADDR) of std_logic_vector(NBIT-1 downto 0); 
signal REGISTERS : REG_ARRAY;

subtype PHY is std_logic_vector(phy_addr-1 downto 0); --used for the fuction 'to_unsigned(...)'
constant starting:PHY:= std_logic_vector(to_unsigned(0,PHY'length)); --first address of the RF
constant ending:PHY:= std_logic_vector(to_unsigned(2*N*(F-1),PHY'length)); --circular buffer max value(2*N*(F-1)),#bit of end=#bit of cwp/swp
signal SWP, CWP:PHY:=(OTHERS=>'0'); --pointers to saved&current windows
signal  CANSAVE, CANRESTORE: std_logic; --control signal to SPILL&FILL (active high)
signal STORE_DATA, RETRIEVE_DATA: std_logic; --used to communicate with memory
signal i: integer range 0 to (2*N-1):=0; --counter index


--function to convert cpu/mem address(virtual:N*3+M ==data length) to physical address(M+2*N*F==data length)=>(2N*F-3N) extension
function conv_addr (wr_rd_addr: std_logic_vector(virt_addr-1 downto 0); cwpointer : std_logic_vector(phy_addr-1 downto 0)) 
return std_logic_vector is
	begin
		if (to_integer(unsigned(wr_rd_addr))< N*3) then  
			return std_logic_vector(unsigned(cwpointer)+ unsigned(wr_rd_addr));
			--if address not link to a global reg, move your current pointer su wr_rd_addr 
		else 
			return std_logic_vector(unsigned(wr_rd_addr)+ to_unsigned(N*(F*2-3), PHY'LENGTH)); --physical_addr=virtual_addr+2*N*F-N*3
			--otherwise if an addr links to a global reg=> not use cwp but use
			--a global address: we know first glob_reg is on 2*N*F, than add to it addr-N*3
		end if;
end function;


		
begin  
	write_proc:process (clk,reset,enable, wr,wr_signal,ADD_WR, DATAIN)
	begin
		--if CLK'event and CLK='1' then
		if reset='0' then
			registers<=(others =>(others =>'0'));
			STORE_DATA <= '0';
			RETRIEVE_DATA <= '0';
			i <= 0;
			BUSout <= (others => '0');

		else if rising_edge(clk) then 
				if enable='1' then
					if wr='1' and wr_signal = '1' then
					registers(to_integer(unsigned(conv_addr(add_wr,CWP))))<=datain;
					end if;
					if STORE_DATA='1' then
					--BUSout<=pointer_to_save, 1 reg per clock, when finish transfer not spill anymore
					BUSout <= registers(to_integer(unsigned(CWP)) + i);
						if (i = (N*2)-1) then --if #registers_sent=2*N, finish transfer 
							STORE_DATA <= '0';
						i <= 0;
						else	i <= i+ 1;
						end if;			--OTHERWISE if you want to use an ACK BIT: if (mem_ack='1') then SPILL <= '0'; end if;
					end if;

					if RETRIEVE_DATA='1' then
					--pointer_to_retrieve<=BUSin, 1 reg per clock, when finish transfer not fill anymore
					registers(to_integer(unsigned(CWP)) +i) <= BUSin; 
						if (i = (N*2)-1) then --if #registers_sent=2*N, finish transfer 
						RETRIEVE_DATA <= '0';
						i <=0;
						else	i <= i+ 1;
						end if; 			--OTHERWISE: if (mem_ack='1') then FILL <= '0'; end if;
					end if;
				end if;
				
			end if;
		end if;
	end process;

	read_proc:process (clk,reset,enable, rd1,rd2,ADD_RD1,ADD_RD2)
	begin
		--if CLK'event and CLK='1' then
		if reset='0' then
			out1<=(others =>'0');
			out2<=(others =>'0');
		else
			if rd1='1' then
				out1<=registers(to_integer(unsigned(conv_addr(add_rd1,CWP))));
			end if;

			if rd2='1' then
				out2<=registers(to_integer(unsigned(conv_addr(add_rd2,CWP))));
			end if;
		end if;
	end process;
			
				--bypass
				--if ((add_wr=add_rd1) and (rd1='1')) then 
				--	out1<=datain;
				--end if;
				--if ((add_wr=add_rd2) and (rd2='1')) then 
				--	out2<=datain;
				--end if;

	call_ret_proc:process (clk,reset,enable,CALL,RETRN)
	begin
		--if CLK'event and CLK='1' then
		if reset='0' then
			SWP<= (others=>'0');
			CWP<= (others=>'0');
 

		else 
			if rising_edge(clk) then 
			if enable='1' then		--if enable do cases for call and return
			--CWP is shifted by 2N positions when call
			--SWP is shifted by 2N positions when spill

 			if CALL='1' then --subroutine calls
			--1.check window space 2.(ONLY IF SPILL)update swp+move data 3.update cwp
				if CANSAVE='1' then--no windows available: SPILL
				STORE_DATA<='1'; --RF rises SPILL signal to external block (e.g.MMU), BUSout use
					if (SWP=ending) then 
						SWP<=(others =>'0');
					else SWP<=std_logic_vector(unsigned(SWP)+to_unsigned(N*2,PHY'length));
					end if;
					----implemented circular buffer swp 
				end if;
				if (CWP=ending)then 
					CWP<=(others =>'0');
				else CWP<=std_logic_vector(unsigned(CWP)+to_unsigned(N*2,PHY'length));
				end if;
		 		--cwp circular buffer mode
			end if;

			--CWP is shifted back by 2N positions when return
			--SWP is shifted back by 2N positions when fill

			if RETRN='1' then --subroutine callbacks
			--1.check swp points 2.(ONLY IF FILL)update swp+move data 3.update cwp (when else not allowed in processes)
				if CANRESTORE='1'then --parent is not in RF: FILL 
				RETRIEVE_DATA<='1'; --RF rises fill because CWP=SWP, BUSin use
					if (SWP=STARTING )then 
						SWP<=ending; 
					else SWP<=std_logic_vector(unsigned(SWP)-to_unsigned(N*2,PHY'length));
					end if;
					--swp circular buffer mode
				end if;
				if (CWP=starting)then 
					CWP<=ending; 
				else CWP<=std_logic_vector(unsigned(CWP)-to_unsigned(N*2,PHY'length));
				end if;
		 		--cwp circular buffer mode
			end if;


		
		end if;--enable
		end if;-- clock
		end if; --reset
	end process;


	-- concurrent assigments
	CANSAVE <= '1' when ( ( (SWP = std_logic_vector(unsigned(CWP)+to_unsigned(N*2,PHY'length))) and (CWP/=ending))or  ((CWP=ending)and(SWP=starting))) else '0';  	
	--0== windows available, 1=SPILL(occurs when incremented CWP equalizes SWP) 
	--when CWP=ending don't add 2N but incremented_CWP=starting (circular buffer behaviour)
	CANRESTORE <= '1' when ((CWP = SWP)and(CWP/=starting)) else '0'; 		
	--0== parent is in RF, 1=FILL(occurs when not yet decremented CWP equalizes SWP)
	--and(CWP/=starting) it's added in case of wrong bhv of machine:for example RETURN='1' right after start or reset

	SPILL<=STORE_DATA;-- when spill flag rises you want to save data in memory to free space
	FILL<=RETRIEVE_DATA; -- when fill flag rises you want to take data from memory to continue the return call

end architecture;

configuration CFG_WINDRF_BHV of windRF is
  for bhv
  end for;
end configuration;
