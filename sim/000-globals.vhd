library ieee;
use ieee.std_logic_1164.all;
use IEEE.math_real.ALL;
package myTypes is

	type aluOp is (
		NOP, ADDS, LLS, LRS, ADD, SUB, ANDR, ORR, XORR, SNE, SLE, SGE, BEQZ, BNEZ, SUBI, ANDI,
		ORI, XORI, SLLI, SRLI, SNEI, SLEI, SGEI, LW, SW,SUBU,SUBUI,ADDU,ADDUI,SRA1,SEQ,SLT,SGT,
		SLTU,SGTU,SGEU,LHI,JR,JALR,SRAI,SEQI,SLTI,SGTI,LB,LBU,LHU,SB,SLTUI,SGTUI,SGEUI,trap,rfe --- to be completed
			);--SRA1,SRAI
	constant MEM_SIZE : integer := 61; 
	constant OP_CODE_SIZE : integer :=  6;                                              -- OPCODE field size
    	constant FUNC_SIZE    : integer :=  11;                                             -- FUNC field size
	constant numBit : integer :=  32;
	constant Numreg : integer := 32; 
	constant REG_SIZE: positive := positive(ceil(log2(real(Numreg))));
	constant num_global_regs : integer := 8;
	constant num_local_inout_regs : integer := 8;
	constant num_windows: integer := 5;
	constant RF_WIDTH: integer := num_local_inout_regs*3+num_global_regs; --N*3+M 
	constant virt_addr: integer := integer(ceil(log2(real(RF_WIDTH)))); --log2(N*3+M) virtual address lenght
 	constant phy_lenght: integer := num_global_regs+2*num_local_inout_regs*num_windows; --physical RF lenght= M+2*N*F
	constant phy_addr: integer:= integer(ceil(log2(real(phy_lenght)))); --physical address lenght= log2(M+2*N*F)

end myTypes;


