package CONSTANTS is
	constant NumBit : integer := 32;
	constant N_PER_BLOCK: integer := 4;
	constant NBLOCKS: integer:= NumBit/N_PER_BLOCK;





	constant IVDELAY : time := 0.1 ns;
	constant NDDELAY : time := 0.2 ns;
 	constant NDDELAYRISE : time := 0.6 ns;
	constant NDDELAYFALL : time := 0.4 ns;
	constant NRDELAY : time := 0.2 ns;
	constant DRCAS : time := 1 ns;
	constant DRCAC : time := 2 ns;
	constant TP_MUX : time := 0.5 ns; 
end CONSTANTS;
