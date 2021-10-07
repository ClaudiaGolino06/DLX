library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


ENTITY G is
		port (
			G1 :	in	std_logic;
			P :		in	std_logic;
			G2 :	in	std_logic;
			Co :	out	std_logic);
	end g;


architecture behave of g is
	begin
	Co<=G1 or (P and G2);
end behave;


configuration CFG_G_behave of G is
	for behave
	end for;
end CFG_g_behave;
