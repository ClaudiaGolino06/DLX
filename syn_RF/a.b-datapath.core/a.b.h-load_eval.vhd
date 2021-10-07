library IEEE;
use IEEE.std_logic_1164.all; 
use work.myTypes.all;
use IEEE.numeric_std.all;

entity load_data is
	port (
	  data_in: in std_logic_vector(31 downto 0);
      signed_val: in std_logic;
	  load_op:  in std_logic;
      load_type: in std_logic_vector(1 downto 0); --load byte, halfword, word (3 valori=2 bit)--2 last bits of opcode
      data_out: out std_logic_vector (31 downto 0));	
end load_data;

architecture bhv_load of load_data is
begin
	load_id: process(data_in)
	begin
		if load_op = '1' then 
			if load_type = "11" then --word
				data_out<= data_in;
			elsif load_type= "01" then --halfword (lhu)
	 			data_out(15 downto 0)<= data_in(15 downto 0);
				data_out(31 downto 16)<= (others=>'0');
			elsif load_type= "00" then --byte (lb e lbu)
	 			data_out(7 downto 0)<= data_in(7 downto 0);
				if signed_val='1' then data_out(31 downto 8)<= (others=>'0');
				else data_out(31 downto 8)<= (others=>data_in(31));
				end if;
			else data_out<= (others=>'0');
			end if;
		end if;
	end process;
end architecture;
