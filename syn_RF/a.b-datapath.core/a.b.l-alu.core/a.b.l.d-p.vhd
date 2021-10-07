library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


ENTITY P is
		port (
			p1	:	in	std_logic;
			P2 :	in	std_logic;
			Co :	out	std_logic);
	end P;

architecture behave of p is
	begin
	Co<=p1 and p2;
end behave;


configuration CFG_P_behavioral of P is
	for behave
	end for;
end CFG_P_behavioral;
