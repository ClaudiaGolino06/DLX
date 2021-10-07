addi r1,r0,#1	#r1=1
addi r2,r0,#6	#r2=6
nop
nop
nop
nop
nop
slli r1,r1,#1
nop
nop
nop
nop
subi r2,r2,#1	
bnez r2,#-6	  	#if r2!=0 back to pc-6	
nop
nop
nop
nop
j #13			#jump to the branch
nop
beqz r0,#2		#jump to the add instruction
nop
nop
addi r4,r0,#23	#r4=23
nop
nop
nop
nop
nop
jr r4		#jump to the address 23
nop
nop
nop
nop
jal #25		#jump to the address 25 and store the NPC to r31
nop
nop
nop
nop
nop
nop
nop
nop
jalr r31	#jump to the instruction at the address r31


#run for 4750ns
