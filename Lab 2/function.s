	.data
Vari:	.word 0,0,0
	.text
	.globl main

main:
	li	t0,5		# i = 5
	li	t1,10		# j = 10
	la	x31,Vari	# x31 => vari
	addi	sp,sp,-8	# push on to stack
	sw	t0,(sp)		# store 5 in memory
	addi	sp,sp,4		# advance pointer
	sw	t1,(sp)		# store 10
	addi	sp,sp,4		# advance pointer
	mv 	a0,t0		# pass 5 into 
	
	jal	AddItUp		# call function
	sw	t1,(x31)	# a = AddItUp( i )
	addi	x31,x31,4	# advance Vari index
	addi	sp,sp,-4	# 
	lw	a0,(sp)
	
	jal	AddItUp		# call function
	sw	t1,(x31)
	addi	x31,x31,4
	addi	sp,sp,-4
	lw	a0,(sp)
	addi	x31,x31,-8
	
	lw	t0,0(x31)
	lw	t1,4(x31)
	add	t2,t0,t1
	addi	x31,x31,8
	sw	t2,(x31)
	j	Exit
	
	
AddItUp:
	addi	t0,zero,0	# i = 0
	addi	t1,zero,0	# x = 0
	
loop1:	
	add	t1,t1,t0	# x = x + i
	addi	t1,t1,1		# x = x + i + 1
	addi	t0,t0,1		# i++
	blt	t0,a0,loop1	# loop
	ret			# return
	
Exit:
