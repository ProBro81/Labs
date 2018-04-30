	.data
Vari: 	.word 	2,0		#Z_0 = 2, I_4 = 0
	.text
	.globl 	main

main:	la 	x31,Vari	#Address of vari array loaded
	lw 	a0,0(x31)	#Z
	lw 	a1,4(x31)	#i
	addi	t0,zero,20	#Con 20
	
loop1:	addi	a0,a0,1		#Z = Z+1
	addi	a1,a1,2		#i = i+2
	beq	a1,t0,n1loop	#if i = 20 ->
	j	loop1		#loop
	
n1loop:	addi	t0,zero,99	#Con 99
loop2:	addi 	a0,a0,1		#Z = Z+1
	beq	a0,t0,loop3	#if Z = 99 ->
	j	loop2		#loop
	
loop3:	addi	a0,a0,-1	#Z = Z-1
	addi	a1,a1,-1	#i = i-1
	beq	a1,zero,end	#if i = 0 ->
	j	loop3		#loop
	
end:	sw	a0,0(x31)	#store i and Z
	sw	a1,4(x31)
