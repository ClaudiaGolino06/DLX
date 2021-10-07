library IEEE;
use IEEE.std_logic_1164.all; --  libreria IEEE con definizione tipi standard logic
use work.myTypes.all;
use ieee.std_logic_arith.all;

entity comparator is
	Port (	DATA1:	In	std_logic_vector(numBit-1 downto 0);
		DATA2i:	In	std_logic;
		tipo :In aluOp;
		OUTALU:	Out	std_logic_vector(numBit-1 downto 0));
end comparator;

architecture Architectural of comparator is


signal s_i: integer;

begin
--this process checks the type of operation and then assigns to the output the value one or zero depending on the value of the two operands
s_i <= conv_integer(unsigned(data1));
comparator_proc: process (s_i, data2i, tipo)
begin
	case tipo is
		when SEQ | SEQI => if s_i=0 then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		when SLT | SLTI | SLTU |SLTUI  => if data2i = '0' then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		
		when SGT | SGTI | SGTUI |SGTU  =>  if data2i = '1' and s_i/=0 then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		
		when SGE| SGEI | SGEUI |SGEU=> if data2i = '1' then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		
		when SNE | SNEI => if s_i/=0 then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		
		when SLE | SLEI => if s_i=0 or data2i = '0' then 
							OUTALU<="00000000000000000000000000000001";
							else
								OUTALU<="00000000000000000000000000000000";
							end if;
		when others => null;
    end case; 
 end process comparator_proc;
end Architectural;
