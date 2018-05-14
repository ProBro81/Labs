		.data
datain_a:	.word 0x01234567
datain_b:	.word 0x11223344
add_test:	.word 0
sub_test:	.word 0
addi_test:	.word 0
and_test:	.word 0
andi_test:	.word 0 
or_test:	.word 0
ori_test:	.word 0
sll_test:	.word 0
slli_test:	.word 0 
srl_test:	.word 0
srli_test:	.word 0 

		.text
		
main:
	li s5,4
	lw s2,datain_a
	lw s3,datain_b
	lw x5,add_test
	lw x6,sub_test
	lw x7,addi_test
	lw x28,and_test
	lw a0, andi_test
	lw x29,or_test
	lw a1,ori_test
	lw x30,slli_test
	lw a2,sll_test
	lw x31,srli_test
	lw a3,srl_test
	
	
	add x5,s2,s3
	sw  x5,add_test,s4
	
	sub x6,s2,s3
	sw  x6,sub_test,s4
	
	addi x7,s2, 15
	sw   x7,addi_test,s4
	
	and x28,s2,s3
	sw  x28, and_test,s4
	
	andi a0,s2,2
	sw   a0,andi_test,s4
	
	or  x29,s3,s3
	sw  x29,or_test,s4
	
	ori a1,s2,4	
	sw  a1,ori_test,s4
	
	sll a2,s2,s5
	sw  a2,sll_test,s4
	
	slli x30,s2,3
	sw x30,slli_test,s4
	
	srl a3,s3,s5
	sw  a3,srl_test,s4
	
	srli x31,s2,5
	sw x31,srli_test,s4
	
	li a7,10
	ecall
