	.data
a:	.word 0
b:	.word 0	
c:	.word 0
	.text

main:	

	addi	a2,zero,3
	jal	fib
	sw	a0,a,t6
	
	addi	a2,zero,10
	jal	fib	
	sw	a0,b,t6
	
	addi	a2,zero,20
	jal	fib
	sw	a0,c,t6
	
	li	a7,10
	ecall

fib:
	addi 	sp,sp,-12
	sw	ra,0(sp)
	sw	s0,4(sp)
	sw	s1,8(sp)
	
	add	s0,a2,zero
	addi	t1,zero,1
	beq	s0,zero,ret0
	beq	s0,t1,ret1
	
	addi	a2,s0,-1
	jal	fib
	add	s1,zero,a0
	addi	a2,s0,-2
	jal	fib
	add	a0,a0,s1
	
exit:
	lw	ra,0(sp)
	lw	s0,4(sp)
	lw	s1,8(sp)
	addi	sp,sp,12
	jr	ra,0
	
ret1:
	li	a0,1
	j	exit
ret0:
	li	a0,0
	j	exit

