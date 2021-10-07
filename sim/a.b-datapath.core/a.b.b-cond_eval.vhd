library IEEE;
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all;
use work.myTypes.all;

entity COND_BT is
Generic (NBIT: integer:= numBit); 
	Port (	
		ZERO_BIT:	in	std_logic;
		OPCODE_0:	in	std_logic; --OpCODE(0) <= IR(26)
		branch_op:	in	std_logic;
		con_sign: out	std_logic);
end COND_BT;


architecture BHV of COND_BT is 
begin 
	dec_cond: process (branch_op, opcode_0,zero_bit)
	begin
	if (branch_op='1' ) then
		con_sign<=opcode_0 xor zero_bit;
	else
	con_sign<='0';
	end if;
	end process;	
end BHV;

-- branch taken--> cond_sign=1
-- bnot taken or not branch opcode-->cond_sign=0;
