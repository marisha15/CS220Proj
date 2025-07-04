.data 
string1 : .asciiz "Enter x "
string2 : .asciiz "Enter y "

.text

pow :
    addi $sp,$sp,-12
    sw $ra,8($sp)
    sw $a1,4($sp)
    sw $a0,0($sp) 

    beq $a1,$zero,label1

    sra $a1,$a1,1
    mul $a0,$a0,$a0

    jal pow

    lw $ra,8($sp)
    lw $a1,4($sp) #y
    lw $a0,0($sp)

    li $t4,2
    rem $t3,$a1,$t4
    addi $sp,$sp,12
    beq $t3,$zero,label2
    mul $v0,$v0,$a0    
    jr $ra

label2 :
    jr $ra

label1 :
    lw $ra,8($sp)
    addi $sp,$sp,12
    li $v0,1
    jr $ra

main :

    li $v0,4
    la $a0,string1
    syscall

    li $v0,5
    syscall

    move $t1,$v0

    li $v0,4
    la $a0,string2
    syscall

    li $v0,5
    syscall

    move $t2,$v0

    move $a0,$t1 # x
    move $a1,$t2 # y

    jal pow

    move $a0,$v0
    li $v0,1
    syscall

    li $v0,10
    syscall