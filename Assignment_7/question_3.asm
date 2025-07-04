.data 
string1 : .asciiz "Enter the number: "
string2 : .asciiz "Invalid entry"
space : .asciiz " "
po : .asciiz "zero"
p1 : .asciiz "one"
p2 : .asciiz "two"
p3 : .asciiz "three"
p4 : .asciiz "four"
p5 : .asciiz "five"
p6 : .asciiz "six"
p7 : .asciiz "seven"
p8 : .asciiz "eight"
p9 : .asciiz "nine"

.text
main : 
    li $v0,4
    la $a0,string1
    syscall

    li $v0,5
    syscall

    move $s1,$v0

    slti $s0,$v0,1
    beq $s0,$zero,label

    li $v0,4
    la $a0,string2
    syscall

    li $v0,10
    syscall

label :

    li $s0,0
    li $s3,0

countzero : 
    li $t0,10
    div $s1,$t0
    mflo $t1
    mfhi $t2
    mul $s0,$s0,$t0
    add $s0,$s0,$t2
    move $s1,$t1
    bne $t2,$zero,loop
    addi $s3,$s3,1
    j countzero

loop : 
    li $t0,10
    div $s1,$t0
    mflo $t1
    mfhi $t2
    mul $s0,$s0,$t0
    add $s0,$s0,$t2
    move $s1,$t1

    beq $s1,$zero,okay
    j loop

okay : 
    li $t0,10
    div $s0,$t0
    mflo $t1
    mfhi $t2
    move $s0,$t1

    li $s2,0
    beq $t2,$s2,label0
    li $s2,1
    beq $t2,$s2,label1
    li $s2,2
    beq $t2,$s2,label2
    li $s2,3
    beq $t2,$s2,label3
    li $s2,4
    beq $t2,$s2,label4
    li $s2,5
    beq $t2,$s2,label5
    li $s2,6
    beq $t2,$s2,label6
    li $s2,7
    beq $t2,$s2,label7
    li $s2,8
    beq $t2,$s2,label8
    li $s2,9
    beq $t2,$s2,label9

label0 : 
        li $v0,4
        la $a0,po
        syscall
        li $v0,4
        la $a0,space
        syscall
        beq $s0,$zero,done
        j okay
label1 : 
        li $v0,4
        la $a0,p1
        syscall
        li $v0,4
        la $a0,space
        syscall
        beq $s0,$zero,done
        j okay
label2 : 
        li $v0,4
        la $a0,p2
        syscall
        li $v0,4
        la $a0,space
        syscall
        beq $s0,$zero,done
        j okay
label3 : 
        li $v0,4
        la $a0,p3
        syscall
        li $v0,4
        la $a0,space
        syscall
        beq $s0,$zero,done
        j okay
label4 : 
        li $v0,4
        la $a0,p4
        syscall
        li $v0,4
        la $a0,space
        syscall
        beq $s0,$zero,done
        j okay
label5 : 
        li $v0,4
        la $a0,p5
        syscall
        li $v0,4
        la $a0,space
        syscall
        beq $s0,$zero,done
        j okay
label6 : 
        li $v0,4
        la $a0,p6
        syscall
        li $v0,4
        la $a0,space
        syscall
        beq $s0,$zero,done
        j okay
label7 : 
        li $v0,4
        la $a0,p7
        syscall
        li $v0,4
        la $a0,space
        syscall
        beq $s0,$zero,done
        j okay  
label8 : 
        li $v0,4
        la $a0,p8
        syscall
        li $v0,4
        la $a0,space
        syscall
        beq $s0,$zero,done
        j okay
label9 : 
        li $v0,4
        la $a0,p9
        syscall
        li $v0,4
        la $a0,space
        syscall
        beq $s0,$zero,done
        j okay
done :
        beq $s3,$zero,exitprogram
        li $v0,4
        la $a0,po
        syscall
        li $v0,4
        la $a0,space
        syscall
        addi $s3,$s3,-1
        j done

exitprogram :    
        li $v0,10
        syscall