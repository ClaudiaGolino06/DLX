library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.math_real.ALL;
use work.constants.all;
use ieee.numeric_std.all;

ENTITY CARRY_GENERATOR is
		generic (
			NBIT :		integer := numbit;
			NBIT_PER_BLOCK: integer := N_PER_BLOCK);
		port (
			A :		in	std_logic_vector(NBIT-1 downto 0);
			B :		in	std_logic_vector(NBIT-1 downto 0);
			Cin :	in	std_logic;
			Co :	out	std_logic_vector(NBLOCKS-1 downto 0));
	end carry_generator;

architecture arch of carry_generator is
	component PG
	port (
			G1 :	in	std_logic;
			P1:		in	std_logic;
			G2 :	in	std_logic;
			P2:		in 	std_logic;
			gout:	out	std_logic;
			pout:	out std_logic);
	end component;
	component g
	port (
			G1 :	in	std_logic;
			P :		in	std_logic;
			G2 :	in	std_logic;
			Co :	out	std_logic);
	end component;
	constant DATA: positive := positive(ceil(log2(real(NBIT))));
	
	constant data2:integer :=N_PER_BLOCK/2;
	constant data1: integer:=(DATA-data2);
	type SignalVector is array (NBIT downto 0) of std_logic_vector(DATA downto 0);
	signal pi: 	SignalVector;
	signal gi:	SignalVector;
	
	
	begin
	--part1
	--the first lines before reaching the correct number of output are managed in this part
	
	ciclepre: for j in 0 to data2-1 generate --caso in cui non ci sono raggruppamenti
		ciclepre1: for i in 1 to NBIT generate
				if1: if j=0 generate	
					t: if i=1 generate 
						gi(i-1)(j)<=a(i-1) and b(i-1);
						pi(i-1)(j)<=a(i-1) xor b(i-1);
						g_port0: g port map(gi(i-1)(j),pi(i-1)(j),Cin, gi(i)(j));
						--gi(i)(j)<=cin;
						--pi(i)(j)<='0';
					end generate;
					if2:if 	i/=1 generate	
						gi(i)(j)<=a(i-1) and b(i-1);
						pi(i)(j)<=a(i-1) xor b(i-1);	
					end generate;
				end generate;
				if3: if i=2**j and j/=0 generate
					g_port1: g port map(gi(i)(j-1),pi(i)(j-1),gi(i/2)(j-1), gi(i)(j)); --controllare gi Secondo
				end generate;
				if4: if j/=0 and i/=2**j generate--(i mod 2*j)/=0 generate --la seconda parte sarebbe la condizione di sopra ma maggiore
					pg_port2: pg port map(gi(i)(j-1),pi(i)(j-1),gi(i-1)(j-1),pi(i-1)(j-1),gi(i)(j),pi(i)(j));
				end generate;
			end generate;
		end generate;
	
	--parte2
	--here are managed the rest of the lines, I divided the line in groups (G block, PG block, lines)
	cicle1: for j in 0 to data1	generate	   			
				if5:if j=0 generate 
					--blocco g singolo
					g_port: g port map(gi(N_PER_BLOCK)(j+data2-1),pi(N_PER_BLOCK)(j+data2-1),gi(N_PER_BLOCK/2)(j+data2-1), gi(N_PER_BLOCK)(j+data2)); 
					co(j)<=gi(N_PER_BLOCK)(j+data2);
				end generate;
				if6:if j/=0 generate
					cicle2:	for i in (2**(j-1))+1 to (2**j) generate	--	blocchi g nero
						g_port: g port map(gi(i*N_PER_BLOCK)(j+data2-1),pi(i*N_PER_BLOCK)(j+data2-1),gi((2**(j-1))*N_PER_BLOCK)(j+data2-1), gi(i*N_PER_BLOCK)(j+data2));
						co(i-1)<=gi(i*N_PER_BLOCK)(j+data2);
					end generate;
				end generate;	

				cicle3:for k in 1 to (NBLOCKS/2**j)-1 generate
					if7:if j/=0 generate
						cicle4:for i in (2**J)*k+(2**(j-1))+1 to (2**j)*k+(2**(j)) generate	--blocco pg (bisogna creare un caso particolare quando j=0)
																							--perchè il programma non prende esponenti negativi
							pg_port2: pg port map(gi(i*N_PER_BLOCK)(j+data2-1),pi(i*N_PER_BLOCK)(j+data2-1),gi(((2**J)*k+(2**(j-1)))*N_PER_BLOCK)(j+data2-1),pi(((2**J)*k+(2**(j-1)))*N_PER_BLOCK)(j+data2-1),gi(i*N_PER_BLOCK)(j+data2),pi(i*N_PER_BLOCK)(j+data2));
						end generate;
						cicle5:for i in ((2**j)*k)+1 to (2**J)*k+(2**(j-1)) generate --senza blocchi vuoto (linee)
								gi(i*N_PER_BLOCK)(j+data2)<=gi(i*N_PER_BLOCK)(j+data2-1);
								pi(i*N_PER_BLOCK)(j+data2)<=pi(i*N_PER_BLOCK)(j+data2-1);
								
							end generate;
						end generate;
						if8:if j=0 generate
							cicle6:for i in (2**J)*k+1 to (2**j)*k+(2**(j)) generate	--blocco pg particolare 
							pg_port2: pg port map(gi(i*N_PER_BLOCK)(j+data2-1),pi(i*N_PER_BLOCK)(j+data2-1),gi((i-1)*N_PER_BLOCK)(j+data2-1),pi((i-1)*N_PER_BLOCK)(j+data2-1),gi(i*N_PER_BLOCK)(j+data2),pi(i*N_PER_BLOCK)(j+data2));
							end generate;
					end generate;
				end generate;
				
					
	end generate;

end arch;


configuration CFG_CARRY_GENERATOR_arch of CARRY_GENERATOR is
	for arch
		for ciclepre
			for ciclepre1
				for if1
					for t
						for all :g
							use configuration work.CFG_G_behave;
						end for;
					end for;
				end for;
				for if3
					for all :g
						use configuration work.CFG_G_behave;
					end for;
				end for;
				for if4
					for all :Pg
						use configuration work.CFG_pg_arch;
					end for;
				end for;	
			end for;
		end for;
		for cicle1
			for if5
				for all :g
						use configuration work.CFG_G_behave;
				end for;
			end for;
			for if6	
				for cicle2
					
						for all :g
							use configuration work.CFG_G_behave;
						end for;
					
				END FOR;
			end for;
			for cicle3
				for if7
					for cicle4
						for all :Pg
							use configuration work.CFG_pg_arch;
						end for;
					end for;
				end for;
				for if8
					for cicle6
						for all :Pg
							use configuration work.CFG_pg_arch;
						end for;
					end for;
				end for;
			end for;	
		end for;
	end for;
end CFG_CARRY_GENERATOR_arch;
