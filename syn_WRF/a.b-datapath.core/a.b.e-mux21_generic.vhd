library IEEE;
use IEEE.std_logic_1164.all; --  libreria IEEE con definizione tipi standard logic
use ieee.std_logic_unsigned.all;
use work.myTypes.all;

entity MUX21_GENERIC is
	GENERIC (NBIT: integer :=numBit--;
		--DELAY_MUX: Time:= tp_mux

);
	Port (	A:	In	std_logic_vector(NBIT-1 DOWNTO 0);
		B:	In	std_logic_vector(NBIT-1 DOWNTO 0);
		SEL:	In	std_logic;
		Y:	Out	std_logic_vector(NBIT-1 DOWNTO 0));
end MUX21_GENERIC;

architecture BEHAVIOR of MUX21_GENERIC IS
  begin
	Y <= A when SEL='1' else B; -- after delay_mux;


end BEHAVIOR;

--we implement here a multiplexer of 32bits
ARCHITECTURE struct of MUX21_GENERIC IS
	
	COMPONENT mux21 
		PORT (a:	In	std_logic;
			b:	In	std_logic;
			s:	In	std_logic;
			y:out std_logic);
	END COMPONENT;

	begin
	      gen: FOR I IN 0 TO NBIT-1 GENERATE
			gen1:mux21 PORT MAP (A(i),B(i),SEL,Y(i));
	end generate;
end struct;



configuration CFG_MUX21_GEN_BEHAVIORAL of MUX21_GENERIC IS
	for BEHAVIOR
	end for;
end CFG_MUX21_GEN_BEHAVIORAL;



configuration CFG_MUX21_GEN_STRUCTURAL of MUX21_GENERIC IS
	for struct
    	for gen
      		for all : mux21
		        use configuration work.CFG_MUX21_STRUCTURAL;
      		end for;
    	end for;
  	end for;
end CFG_MUX21_GEN_STRUCTURAL;

