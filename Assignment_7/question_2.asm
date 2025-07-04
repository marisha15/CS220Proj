.data
string1 : .asciiz "Enter Number: "
string2 : .asciiz "Total sum is: "
.text
main : 

    li $s0,0

loop : 
    li $v0,4
    la $a0,string1
    syscall

    li $v0,5
    syscall

    add $s0,$s0,$v0

    beq $v0,$zero,label

    j loop

label : 
    li $v0,4
    la $a0,string2
    syscall

    move $a0,$s0
    li $v0,1
    syscall 

    li $v0,10
    syscall
