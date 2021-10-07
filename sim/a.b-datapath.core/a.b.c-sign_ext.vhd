library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all;
--use WORK.constants.all;
use work.myTypes.all;

entity sign_eval is
	generic (N_in: integer := numBit;
           N_out: integer := numBit);
	port (
		IR_out: in std_logic_vector(N_in-1 downto 0);
      signed_val: in std_logic; 
      Immediate: out std_logic_vector (N_out-1 downto 0));
end sign_eval;


--we extend the sign to 32 bits
architecture BHV of sign_eval is
	constant zeros : std_logic_vector(N_out-N_in-1 downto 0) := (others => '0');
	constant ones : std_logic_vector(N_out-N_in-1 downto 0) := (others => '1');
	
	begin
		immediate <= ones&IR_out when (signed_val = '0' and IR_out(N_in-1) = '1') else zeros&IR_out;
		
end BHV;
