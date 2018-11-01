.data 

Vector: .word 0 0 0 0 0 0 0 0
	
.text
#andi
	#addi $s0, $zero, 5
	#andi $t0, $s0, 3

	lui $1, 0x00001001       
	ori $s1, $1, 0x00000000
	
	addi $t0, $zero, 1
	add  $s0, $t0, $t0
	
	jal ET	
	
	addi $t0, $zero, 2
	
	j END
	
ET:
	addi $t1, $zero, 5
	addi $t0, $zero, 6

	jr $ra

END: