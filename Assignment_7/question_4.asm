.data 
string1 : .asciiz "Enter Number: "

.text
main :
    li $v0,4
    la $a0,string1
    syscall

    li $v0,5;
    syscall
    move $t1,$v0

    li $s0,1
    li $s1,1
    move $s2,$t1
    addi $s2,$s2,1

loop : 
    addi $s1,$s1,1
    beq $s1,$s2,label
    mul $s0,$s0,$s1
    j loop
label : 
    move $a0,$s0
    li $v0,1
    syscall 
    
    li $v0,10
    syscall


