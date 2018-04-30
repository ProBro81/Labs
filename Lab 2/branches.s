	.data
memory: .word 10, 15, 6, 0
	.text
	.globl main 

main:
	la   	x31,memory	#Address of memory in reg 31
	lw   	a0,0(x31) 	#A -- 10
	lw   	a1,4(x31) 	#B -- 15
	lw   	a2,8(x31)  	#C -- 6
	lw   	a3,12(x31)  	#Z -- Variable
	
	addi 	t0,zero,5  	#temp con 5
	slt  	x18,a0,a1  	#A < B
	slt  	x19,t0,a2  	#C > 5
	bne  	x18,x19,ELSEIF 	#if (A < B && C > 5)
	addi 	a3,zero,-1 	#case 1
	
	j Exit
	
ELSEIF:	addi	t0,zero,7  	#temp con 7
	addi 	t1,zero,1  	#temp con 1
	addi 	t3,a2,1    	#c+1
	bne  	t3,t0,Ceq7  	#C=!7
	addi 	a3,zero,-2 	#case 2
	
	j Exit
	
Ceq7:   beq  	a0,a1,ELSE
	blt  	a1,a0,ELSE  	#A>!B
	addi 	a3,zero,-2 	#case 2
	
	j Exit
	
ELSE:   addi 	a3,zero,-3 	#case 3
	
        j Exit
	
Exit:	sw   	a3,12(x31)