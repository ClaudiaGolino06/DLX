library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


ENTITY PG is
		port (
			G1 :	in	std_logic;
			P1:		in	std_logic;
			G2 :	in	std_logic;
			P2:		in 	std_logic;
			gout:	out	std_logic;
			pout:	out std_logic);
	end pg;


architecture arch of PG is
	component P
		port (
			p1	:	in	std_logic;
			P2 :	in	std_logic;
			Co :	out	std_logic);
	end component;
	component g
		port (
			G1 :	in	std_logic;
			P :		in	std_logic;
			G2 :	in	std_logic;
			Co :	out	std_logic);
	end component;
	begin
	g_comp: g port map(g1,p1,g2,gout);
	p_comp: P port map(p1,p2,pout);
end arch;


configuration CFG_pg_arch of PG is
	for arch
		for all :P
			use configuration work.CFG_P_behavioral;
		end for;
		for all :g
			use configuration work.CFG_G_behave;
		end for;
	end for;
end CFG_pg_arch;
