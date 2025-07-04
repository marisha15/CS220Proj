.data
array:   .word 10, 5, 6, 8, 9, 2, 4, 1, 3, 7  
arr_size: .word 10
space:   .asciiz " "
endline: .asciiz "\n"

.text
main:
    la $a0, array
    lw $t0, arr_size
    li $t1, 0
    li $t2, 0
    print1:
        lw $a0,0($a0)
        li $v0, 1
        syscall
        
        la $a0, space
        li $v0, 4
        syscall

        la $a0, array
        addi $t1,$t1,1
        addi $t2,$t2,4
        add $a0,$a0,$t2
        blt $t1,$t0,print1

    la $a0, endline
    li $v0, 4
    syscall
    syscall

    lw $t0, arr_size
    la $a0, array
    jal bubble_sort

    bubble_sort:
        li $t1, 0                    #i
        loopi:
            la $a0, array
            li $t2, 0                #j   
            li $t3, -1
            add $t3,$t3,$t0
            sub $t3,$t3,$t1
            loopj:
                lw $t5, 4($a0)
                lw $t6, 0($a0)
                slt $t4,$t5,$t6
                beq $t4,0,exitj
                swap:
                    lw $t5,4($a0)
                    lw $t7,0($a0)
                    sw $t7,4($a0)
                    sw $t5,0($a0)
                exitj:
                    addi $t2,$t2,1
                    addi $a0,$a0,4
                    ble $t2, $t3, loopj
            addi $t1,$t1,1
            ble $t1,$t0,loopi


    la $a0, array
    lw $t0, arr_size
    li $t1, 0
    li $t2, 0
    print2:
        lw $a0,0($a0)
        li $v0, 1
        syscall
        
        la $a0, space
        li $v0, 4
        syscall

        la $a0, array
        addi $t1,$t1,1
        addi $t2,$t2,4
        add $a0,$a0,$t2
        blt $t1,$t0,print2

    la $a0, endline
    li $v0, 4
    syscall

    li $v0, 10
    syscall
