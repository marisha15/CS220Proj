 .data

inp : .asciiz "Enter Number: " 
string1 : .asciiz "Moving from "
string2 : .asciiz " to "
string3 : .asciiz "\n"

.text

hanoi : 

    addi $sp,$sp,-20
    sw $ra, 16($sp)
    sw $a0, 12($sp)
    sw $a1, 8($sp)
    sw $a2, 4($sp)
    sw $a3, 0($sp)

    beq $a0, $zero, label1

    addi $a0, $a0, -1
    move $t0, $a2
    move $a2, $a3
    move $a3, $t0

    jal hanoi


    lw $ra, 16($sp)
    lw $a0, 12($sp)
    lw $a1, 8($sp)
    lw $a2, 4($sp)
    lw $a3, 0($sp)

    li $v0, 4
    la $a0, string1
    syscall

    li $v0, 1
    move $a0, $a1
    syscall
    
    li $v0, 4
    la $a0, string2
    syscall

    li $v0, 1
    move $a0, $a3
    syscall

    li $v0, 4
    la $a0, string3
    syscall

    lw $a0, 12($sp)

    addi $a0, $a0, -1
    move $t0, $a1
    move $a1, $a2
    move $a2, $t0

    jal hanoi

    lw $ra, 16($sp)
    addi $sp, $sp, 20

    jr $ra
    


label1:
    
    addi $sp, $sp, 20
    jr $ra

 main :

    li $v0,4
    la $a0,inp
    syscall

    li $v0,5
    syscall

    move $a0,$v0
    li $a1,1
    li $a2,2
    li $a3,3
    jal hanoi

    li $v0,10
    syscall

