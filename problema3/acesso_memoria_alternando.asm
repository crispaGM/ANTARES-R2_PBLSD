.text
li $t1, 1
addi $t1, $t1, 1

gravacao:
move $a0,$t1
li $t3, 65535
sw $a0, $t3
beq $t3,65535,polling

polling:
lw $a0,65535
bne $a0, 0, operacao2
J polling

operacao2:
addi $t1, $t1 1
j gravacao2

gravacao2:
move $a0,$t1
li $t3, 600000
sw $a0, $t3
beq $t3,65535,polling2
J exit

polling2:
lw $a0,65536
bne $a0, 0, exit
J polling

exit: