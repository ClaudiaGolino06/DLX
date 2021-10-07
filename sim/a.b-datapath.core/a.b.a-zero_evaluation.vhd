library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;

entity zero_eval is
  generic (NBIT:integer:= 32);
  port (
    input: in  std_logic_vector(NBIT-1 downto 0);
    res: out std_logic );
end zero_eval;

architecture bhv of zero_eval is
	--set the output to 1 when the input is zero, otherwise set the output to zero
	begin
		res <= '1' when input=std_logic_vector(to_unsigned(0, input'length)) else '0';
		
end architecture;
								   
