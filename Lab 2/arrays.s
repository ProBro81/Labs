	.data
B:	.word 1,2,4,8,16
	.text
	.globl main

main:	addi	sp,sp,-20	#A[5] = 4*[5] = 20
	add 	t0,zero,zero	#t0 = i
	la	x31,B		#x31 gets array B
	
	li	t3,5		#Con 5
loop1:	lw	t1,(x31)	#t1 = B[i]
	addi	t1,t1,-1	#t1 = B[i] - 1
	sw	t1,(sp)		#A[i] = B[i] - 1
	addi	t0,t0,1		#i++
	addi	sp,sp,4		#increment index
	addi	x31,x31,4	#increment index
	beq	t0,t3,nloop	#if i = 5 ->
	j	loop1		#loop

nloop:	addi	t0,t0,-1	#i--
	addi	sp,sp,-4	#decrement index
	addi	x31,x31,-4	#decrement index
	
	li	t3,2		#Con 2
loop2:	lw	t1,(x31)	#t1 = B[i]
	lw	t2,(sp)		#t2 = A[i]
	add	t1,t1,t2	#t1 = A[i] + B[i]
	mul	t1,t1,t3	#t1 = (A[i] + B[i])*2
	sw	t1,(sp)		#A[i] = (A[i] + B[i])*2
	addi	t0,t0,-1	#i--
	addi	sp,sp,-4	#decrement index
	addi	x31,x31,-4	#decrement index
	blt	t0,zero,end	#if i = 0 ->
	j	loop2		#loop	
end:
