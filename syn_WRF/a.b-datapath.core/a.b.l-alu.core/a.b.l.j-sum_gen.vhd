library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use WORK.constants.all;
 
entity SUM_GENERATOR is
	generic (
		NBIT_PER_BLOCK: integer := N_PER_BLOCK;
		NBLOCKS:	integer := NBLOCKS);
	port (
		A:	in	std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0);
		B:	in	std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0);
		Ci:	in	std_logic_vector(NBLOCKS-1 downto 0);
		S:	out	std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0));
	end SUM_GENERATOR;

architecture STRUCTURAL of SUM_GENERATOR is

component CSB is 
	generic (NBIT: integer:= N_PER_BLOCK);  
	Port (	A:	In	std_logic_vector(NBIT-1 downto 0); 
		B:	In	std_logic_vector(NBIT-1 downto 0); 
		Ci:	In	std_logic; 			  
		S:	Out	std_logic_vector(NBIT-1 downto 0)); 			   
end component; 


begin
 	SumBlock: for I in 0 to NBLOCKS-1  generate
    	CSBI : CSB
	 	 Port Map ( A(I*NBIT_PER_BLOCK+NBIT_PER_BLOCK-1 downto I*NBIT_PER_BLOCK),	
					B(I*NBIT_PER_BLOCK+NBIT_PER_BLOCK-1 downto I*NBIT_PER_BLOCK), 
					Ci(I), 
					S(I*NBIT_PER_BLOCK+NBIT_PER_BLOCK-1 downto I*NBIT_PER_BLOCK));
  	end generate;

end STRUCTURAL;



configuration CFG_SUM_GENERATOR_STRUCTURAL of SUM_GENERATOR is
  for STRUCTURAL
	for SumBlock
    		for all: CSB
        		use configuration WORK.CFG_CSB_STRUCTURAL;
      		end for;
      end for;
  end for;
end CFG_SUM_GENERATOR_STRUCTURAL;

