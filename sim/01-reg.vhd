library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all;
--use IEEE.std_logic_unsigned.all;
use work.myTypes.all;


entity regFFD is
Generic (NBIT: integer:= numBit); --number of bit of  the register
	Port (	
		CK:	In	std_logic;
		RESET:	In	std_logic;
		ENABLE: In 	std_logic;
		D:	In	std_logic_vector(NBIT-1 downto 0);
		Q:	Out	std_logic_vector(NBIT-1 downto 0));
		
end regFFD;


architecture SYNCBEHAV of regFFD is -- flip flop D with syncronous reset

begin
	PSYNCH: process(CK,RESET,ENABLE) 
	begin
	  if CK'event and CK='1' then 	-- positive edge triggered:
	    if RESET='0' then 			-- active low reset 
	      Q <= (others =>'0'); 
	    elsif ENABLE='1' then 		-- active high enable
	      Q <= D; 					-- input is written on output
	    end if;
	  end if;
	end process;

end SYNCBEHAV ;

architecture ASYNCHBEHAV of regFFD is -- flip flop D with asyncronous reset

begin
	
	PASYNCH: process(CK,RESET,ENABLE)
	begin
	  if RESET='0' then
	    Q <= (others =>'0');
	  elsif CK'event and CK='1' and ENABLE ='1' then -- positive edge triggered, active high enable:
		Q <= D; 
	  end if;
	end process;

	--(it can also be written:)
	--if RESET='1' then
	--   Q <= (others =>'0');
	--elsif CK'event and CK='1' then 	-- positive edge triggered
	--	 if ENABLE ='0' then	 		--active low enable, if EN='1' Q will have the previous value
	--		Q <= D; 
	--	end if;
	--end if; 

end ASYNCHBEHAV ;


configuration CFG_FD_SYNC of regFFD is
	for SYNCBEHAV 
	end for;
end CFG_FD_SYNC;


configuration CFG_FD_ASYNC of regFFD is
	for ASYNCHBEHAV 
	end for;
end CFG_FD_ASYNC;
