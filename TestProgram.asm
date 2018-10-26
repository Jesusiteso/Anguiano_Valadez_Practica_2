.data 

Vector: .word 0 0 0 0 0 0 0 0
	
.text
#andi
	addi $s0, $zero, 5
	andi $t0, $s0, 3

	lui $1, 0x00001001       
	ori $s1, $1, 0x00000000 
#sw	
	#sw $s0, ($s1)
	#sw $t0, -4($s1)
#lw	
	#lw $t1, ($s1)
	#lw $t0, -4($s1)
#j	
	#j SALTO 
	
	lui $s0, 0x00000101
	ori $s1, $s0, 0x24
	addi $s2, $zero, 1
	addi $s3, $zero, 32
	sll $t0, $s2, 4
	srl $t1, $s3, 4
	sub $t2, $t0, $t1
	
SALTO:

	addi $s0, $zero, 1
	
	
