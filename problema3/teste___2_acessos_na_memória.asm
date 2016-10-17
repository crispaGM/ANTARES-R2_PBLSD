.text
li $t1, 1
addi $t1, $t1, 1

gravacao:
move $a0,$t1
li $t3, 65535
sw $a0, $t3
J polling

polling:
lw $a0,65536
bne $a0, 0, operacao2
J polling

operacao2:
addi $t1, $t1 1
j gravacao2

gravacao2:
move $a0,$t1
li $t3, 65535
sw $a0, $t3
J polling2

polling2:
lw $a0,65535
bne $a0, 0, exit
J polling

exit:
