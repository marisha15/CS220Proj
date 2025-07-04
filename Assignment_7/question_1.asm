.data 

numbers : .word -1,1,-2,1,1,1,1,1,1,1
string1 : .asciiz "Second Maximum Number: "
string2 : .asciiz "Second Minimum Number: "
space : .asciiz " "
string3 : .asciiz " All elements are equal hence no second min and max"

.text

main :
    la $s0,numbers # address of start
    lw $t0,0($s0) # max
    lw $t1,0($s0) # min
    lw $t6,0($s0)
    li $t3,40 # last index
    li $t4,0 # start index
    li $t5,1 # count
loop : 
    addi $t4,$t4,4

    slt $s2,$t4,$t3
    beq $s2,$zero,over

    add $s1,$s0,$t4
    lw $s1,0($s1)

    beq $s1,$t6,count

findmax:
    slt $s2,$t0,$s1
    bne $s2,$zero,maxi

findmin:     
    slt $s2,$t1,$s1
    beq $s2,$zero,mini
    j loop

count : 
    addi $t5,$t5,1
    j findmax

maxi : 
    move $t0,$s1
    j findmin

mini : 
    move $t1,$s1
    j loop

over :
    addi $t5,$t5,-10
    beq $t5,$zero,nounique
    move $s5,$t1 # 2nd max element
    move $s6,$t0 # 2 mini element
    li $t3,40 # last index
    li $t4,-4 # start index
    j loop2

nounique : 
    la $a0,string3
    li $v0,4
    syscall
    li $v0,10
    syscall

loop2 : 
    addi $t4,$t4,4

    slt $s2,$t4,$t3
    beq $s2,$zero,over2

    add $s1,$s0,$t4
    lw $s1,0($s1)
    
    slt $s2,$s1,$t0
    bne $s2,$zero,maxi2

findmin2 :  
    slt $s2,$t1,$s1
    bne $s2,$zero,mini2

    j loop2

maxi2 :
    slt $s2,$s5,$s1
    bne $s2,$zero,maxi3
    j findmin2

maxi3 :
    move $s5,$s1
    j findmin2

mini2 : 
    slt $s2,$s6,$s1
    beq $s2,$zero,mini3
    j loop2

mini3 :
    move $s6,$s1
    j loop2

over2 : 
    la $a0,string1
    li $v0,4
    syscall
    move $a0,$s5
    li $v0,1
    syscall
    la $a0,string2
    li $v0,4
    syscall
    move $a0,$s6
    li $v0,1
    syscall
    li $v0,10
    syscall