	
.text
	lui $s0, 0x00000101
	ori $s1, $s0, 0x24
	addi $s2, $zero, 1
	addi $s3, $zero, 32
	sll $t0, $s2, 4
	srl $t1, $s3, 4
	sub $t2, $t0, $t1
	
	
