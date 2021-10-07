library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.constants.all;
 
--NBIT_PER_BLOCK:=4
--NBLOCKS:=8

entity P4_ADDER is
	generic (
		NBIT :		integer := Numbit);
	port (
		A :	in	std_logic_vector(NBIT-1 downto 0);
		B :	in	std_logic_vector(NBIT-1 downto 0);
		Cin :	in	std_logic;
		S :	out	std_logic_vector(NBIT-1 downto 0);
		Cout :	out	std_logic);
end entity;
	

architecture STRUCTURAL of P4_ADDER is

signal Cout_gen: std_logic_vector(NBLOCKS-1 downto 0);
signal Cin_sum : std_logic_vector(NBLOCKS-1 downto 0);

	component SUM_GENERATOR is
	generic (
		NBIT_PER_BLOCK: integer := 4;
		NBLOCKS:	integer := 8);
	port (
		A:	in	std_logic_vector(N_PER_BLOCK*NBLOCKS-1 downto 0);
		B:	in	std_logic_vector(N_PER_BLOCK*NBLOCKS-1 downto 0);
		Ci:	in	std_logic_vector(NBLOCKS-1 downto 0);
		S:	out	std_logic_vector(N_PER_BLOCK*NBLOCKS-1 downto 0));
	end component;

	component CARRY_GENERATOR is
		generic (
			NBIT :		integer := N_PER_BLOCK*NBLOCKS;
			NBIT_PER_BLOCK: integer := 4);
		port (
			A :		in	std_logic_vector(NBIT-1 downto 0);
			B :		in	std_logic_vector(NBIT-1 downto 0);
			Cin :	in	std_logic;
			Co :	out	std_logic_vector((NBIT/NBIT_PER_BLOCK)-1 downto 0));
	end component;


begin
	carry_logic: CARRY_GENERATOR  
		port map (A, B, Cin, Cout_gen);
	

	
 	Cin_sum <= Cout_gen(NBLOCKS-2 downto 0)&Cin;
 
	sum_logic: SUM_GENERATOR 
   		port map (A, B, Cin_sum, S);
   	Cout <= Cout_gen(NBLOCKS-1);
end STRUCTURAL;

configuration CFG_p4_adder of P4_ADDER is
	for STRUCTURAL
		for all:CARRY_GENERATOR 
			use configuration work.CFG_CARRY_GENERATOR_arch;
		end for;		
		for all: SUM_GENERATOR		
			use configuration work.CFG_SUM_GENERATOR_STRUCTURAL;
		end for;
	end for;
end CFG_p4_adder;

