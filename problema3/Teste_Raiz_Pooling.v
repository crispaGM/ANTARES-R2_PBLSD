
.text
li $t0,16
	li $t1, 1 # resultado da raiz
	li $t2,1  # somatorio
	li $t3,1

	loop:
	
	beq $t2,$t0,gravacao 
        addi $t3,$t3,2
        add $t2,$t2,$t3
        
	addi $t1, $t1,1
	J loop
	
	gravacao:
	move $a0,$t1
	sw $a0,900000($s0)
	J pooling


	pooling:
	lw $a0,65536
	bne $a0, 0,exit
    J pooling






	exit: