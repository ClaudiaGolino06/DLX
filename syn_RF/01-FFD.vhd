library IEEE;
use IEEE.std_logic_1164.all;

entity FF is
	port (
		CLK, RESET, EN, D : in std_logic; --reset active low, en active high
		Q : out std_logic
	);
end entity;

architecture ASYNCH_BHV of FF is
begin

	process(CLK,RESET,EN)
	begin
			if RESET='0' then
				Q <= '0';
			elsif CLK'event and CLK='1' and EN='1' then 
				Q <= D;
			end if;
	end process;
	
end ASYNCH_BHV;



architecture SYNC_BHV of FF is
begin

	process(CLK,RESET,EN)
	begin
		if CLK'event and CLK='1' then
			if RESET='0' then
				Q <= '0';
			elsif EN='1' then
				Q <= D;
			end if;
		end if;
	end process;

end SYNC_BHV;


configuration CFG_FFD_SYNC of FF is
	for SYNC_BHV
	end for;
end CFG_FFD_SYNC;


configuration CFG_FFD_ASYNC of FF is
	for ASYNCH_BHV 
	end for;
end CFG_FFD_ASYNC;
