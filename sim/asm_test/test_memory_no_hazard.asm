addi r1,r0,#15
addi r2,r0,#-7
nop
nop
nop
nop
nop
sw 1(r0),r2
sb 1(r1),r1
nop
nop
nop
nop
nop
lw r3,1(r0)   	#r3=-7
lw r4,1(r1)		#r4=15
lb r5,1(r0)		#r5=-7
lb r6,1(r1)		#r6=15
lbu r7,1(r0)	#r7=249
lbu r8,1(r1)	#r8=15
lhu r9,1(r0)	#r9=65529
lhu r10,1(r1)	#r10=15
nop
nop
nop
nop
nop
nop
nop


#run for 1150ns

