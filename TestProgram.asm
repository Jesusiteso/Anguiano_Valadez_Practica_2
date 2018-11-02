# Authors: Jesus Antonio Valadez Flores
#          Omar Anguiano
# Date: Sep 12, 2018
# Description: Torres de Hanoi;

.data

#inicializacion de los apuntadores de torres
Torre_1: .word 0 0 0 0 0 0 0 0
Torre_2: .word 0 0 0 0 0 0 0 0
Torre_3: .word 0 0 0 0 0 0 0 0

.text

Main:

#Variables temporales y contadores
#empty yet


#Registros con direccion de torres (punteros)
lui $1, 0x00001001       
ori $s1, $1, 0x00000000  
lui $1, 0x00001001       
ori $s2, $1, 0x00000020 
lui $1, 0x00001001       
ori $s3, $1, 0x00000040

#Carga el numero de anillos
addi $s0, $zero, 8

#Inicializa la torre source con los anillos correspondientes
add $t0, $s0, $zero

Filler:
sw $t0, ($s1)
addi $s1, $s1, 4
addi  $t0, $t0, -1
bne $t0, $zero, Filler

jal FHanoi

j End

#fFuncion Hanoi
FHanoi:

# Flag funcion recursiva
addi $t0, $zero, 0

beq $s0, 1, Caso1
beq $s0, 2, Caso2

beq $t0, $zero, Hanoi

jr $ra


#Caso para n == 1 (111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111)
Caso1:
addi $t0, $zero, 1

# mueve ficha
lw $t1, -4($s1)
sw $zero, -4($s1)
sw $t1, ($s3)


# modifica los punteros
addi $s1, $s1, -4
addi $s3, $s3, 4

j End

#Caso para n == 2  (22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222)
Caso2:
addi $t0, $zero, 2

#S -> A
lw $t1, -4($s1)
sw $zero, -4($s1)
sw $t1, ($s2)
addi $s1, $s1, -4
addi $s2, $s2, 4
#S -> D
lw $t1, -4($s1)
sw $zero -4($s1)
sw $t1, ($s3)
addi $s1, $s1, -4
addi $s3, $s3, 4
#A -> D
lw $t1, -4($s2)
sw $zero -4($s2)
sw $t1, ($s3)
addi $s2, $s2, -4
addi $s3, $s3, 4

j End

Hanoi:

bne $s0, 3, Else

# rutina de 3 discos (caso 3)
# S1 -> D3
lw $t1, -4($s1)
sw $zero, -4($s1)
sw $t1, ($s3)

# S2 -> A1
lw $t1, -8($s1)
sw $zero, -8($s1)
sw $t1, ($s2)

# D3 -> A2
lw $t1, ($s3)
sw $zero, ($s3)
sw $t1, 4($s2)

# S3 -> D3
lw $t1, -12($s1)
sw $zero, -12($s1)
sw $t1, ($s3)

# A2 -> S3
lw $t1, 4($s2)
sw $zero, 4($s2)
sw $t1, -12($s1)

# A3 -> D2
lw $t1, ($s2)
sw $zero, ($s2)
sw $t1, 4($s3)

# S3 -> D3
lw $t1, -12($s1)
sw $zero, -12($s1)
sw $t1, 8($s3)

addi $s1, $s1, -12
addi $s3, $s3, 12

jr $ra

Else:

# -------------------------------------------------------hanoi( altura - 1, origen, destino, aux);
# Guarda los datos en el Stack
addi $sp, $sp, -4   # Disminuye el Stack pointer
sw $ra, 0($sp)       # Guarda Return Address.

# Cambia el destino por el auxiliar.
add $s4, $s2, $zero
add $s2, $s3, $zero
add $s3, $s4, $zero
# Disminuye la altura
addi $s0, $s0, -1

jal Hanoi

# Aumenta la altura
addi $s0, $s0, 1

# Cambia el destino por el auxiliar (repone).
add $s4, $s2, $zero
add $s2, $s3, $zero
add $s3, $s4, $zero

# Carga los datos del Stack
lw $ra, 0($sp)      # Cargando Return Address
addi $sp, $sp, 4    # Incrementa el Stack Pointer

# ------------------------------------------------------- Se mueven las fichas
# mueve ficha
lw $t1, -4($s1)
sw $zero, -4($s1)
sw $t1, ($s3)

# modifica los punteros
addi $s1, $s1, -4
addi $s3, $s3, 4

#-------------------------------------------------------hanoi( altura - 1, aux, origen, destino)
# Guarda los datos en el Stack
addi $sp, $sp, -4   # Disminuye el Stack pointer
sw $ra, 0($sp)       # Guarda Return Address.

# Cambia el origen por el auxiliar.
add $s4, $s1, $zero
add $s1, $s2, $zero
add $s2, $s4, $zero
# Disminuye la altura
addi $s0, $s0, -1

# se vuelve a llamar
jal Hanoi

# Aumenta la altura
addi $s0, $s0, 1

# Cambia el origen por el auxiliar (repone).
add $s4, $s1, $zero
add $s1, $s2, $zero
add $s2, $s4, $zero

# Carga los datos del Stack
lw $ra, 0($sp)      # Cargando Return Address
addi $sp, $sp, 4    # Incrementa el Stack Pointer

jr $ra

End:
# End of code D: