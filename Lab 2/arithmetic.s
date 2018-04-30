main:
	addi a0,zero,15
	addi a1,zero,10
	addi a2,zero,5
	addi a3,zero,2
	addi a4,zero,18
	addi a5,zero,-3
	addi a6,zero,0
	
	sub x18,a0,a1	# register x18 contains A-B
	mul x19,a2,a3 	# register x19 contains C*D
	sub x20,a4,a5   # register x20 contains E-F
	div x21,a0,a2   # register x21 contains A/C
	
	add x22,x18,x19 # register x22 contains x18 ,x19
	sub x23,x20,x21 # register x23 contains x20,x21
	add a6,x22,x23  # register a6 contains x22,x23
	sw  a6,(sp)	# store 33 into memory