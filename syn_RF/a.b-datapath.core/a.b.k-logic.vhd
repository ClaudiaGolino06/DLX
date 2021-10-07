library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.myTypes.all;


entity logic is
  generic (N : integer := numBit);
  port 	 ( 	FUNC: IN aluOp;
           DATA1, DATA2: IN std_logic_vector(N-1 downto 0);
           OUT_ALU: OUT std_logic_vector(N-1 downto 0));
end logic;



architecture Architectural of logic is
signal OUTPUT_alu_i:std_logic_vector(N-1 downto 0);
begin
	P_ALU: process (func, DATA1, DATA2)
	 begin
		case func is
			
			when ANDR => gen_and: for i in 0 to N-1 loop
									OUTPUT_alu_i(i) <= DATA1(i) and DATA2(i); 	-- and op
							 end loop;  
			when ORR  => gen_or: for i in 0 to N-1 loop
									OUTPUT_alu_i(i) <= DATA1(i) or DATA2(i);    	-- or op
							 end loop; 
			when XORR => gen_xor: for i in 0 to N-1 loop
									OUTPUT_alu_i(i) <= DATA1(i) xor DATA2(i);	--xor op
							 end loop; 
			when ANDI => gen_and1: for i in 0 to N-1 loop
									OUTPUT_alu_i(i) <= DATA1(i) and DATA2(i); 	-- and op
							 end loop;  
			when ORI  => gen_or1: for i in 0 to N-1 loop
									OUTPUT_alu_i(i) <= DATA1(i) or DATA2(i);    	-- or op
							 end loop; 
			when XORI => gen_xor1: for i in 0 to N-1 loop
									OUTPUT_alu_i(i) <= DATA1(i) xor DATA2(i);	--xor op
							 end loop; 
			when others => OUTPUT_ALU_i<=(others =>'0');	
		end case;
			
	end process;
	out_alu<=OUTPUT_alu_i;
end Architectural;
					 
