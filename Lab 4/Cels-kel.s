	.data
input:	 .asciz "Enter Faranheit value: "
celsius: .asciz "Celsius: "
kelvin:	 .asciz " Kelvin: "

absZero: .float 273.15
val1:	.float 5.0
val2:	.float 9.0
val3:	.float 32.0
	 .text

main:

	li a7,4	# 4 is "print string" service number
	la a0, input	# print input
	ecall
	
	li a7,6	# 6 is "read float" service numeber
	ecall
	fmv.s ft1,fa0#  when we call service number 6, the float is automatically stored $fa0
		       # and on line 2 we're storing that value from fa0 to ft1
	jal converter  # jump and link to the temperature converter
	
			
	li a7, 4
	la a0, celsius # using service # 4 again to get Celsius value input
	ecall
	
	fmv.s fa0,ft7 # store ft7 to fa0 to print
	li a7,2
	ecall

	li a7,4
	la a0, kelvin
	ecall
	
	fmv.s fa0,ft8 # store ft8 to fa0 to print
	li a7, 2
	ecall
	
	li a7, 10  # 10 is service number for "exit execution"
	ecall
	
	
converter:
	flw ft9, val1,t0	# store val1 to ft9
	flw ft10,val2,t0	# store val2 to ft10
	flw ft11,val3,t0	# store val3 to ft11
	
	#Celsius converter
	fsub.s ft11,ft1,ft11	# ft11 = fahr - 32
	fdiv.s ft9,ft9,ft10	# ft9  = 5.0/9.0
	fmul.s ft7,ft11,ft9	# ft7  = (fahr-32)*(5.0/9.0)

		
	
	#Kelvin converter
	flw ft5,absZero,t0	# store absZero ro ft5
	fadd.s ft8,ft7,ft5	# ft8 = cels + 273.15
	
	ret

#END
	
	
