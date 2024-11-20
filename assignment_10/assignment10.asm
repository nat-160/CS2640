.text

    subiu $sp, $sp, 4 #space for x at 0($sp)

    main:
        li $t0, 0
        sw $t0, 0($sp)
        #3 words: 0-x, 4-return, 8-$ra
        subiu $sp, $sp, 12
        sw $t1, 0($sp)
        jal sumton
        lw $t2, 4($sp)
        lw $ra, 8($sp)
        addiu $sp, $sp, 12
        sw $t2, 0($sp)
        move $a0, $t2
        #print x
        li $v0, 1
        syscall
        #exit gracefully
        li $v0, 10
        syscall

    sumton:
        lw $t0, 0($sp)
        bgt $t0, 1, else
        li $t1, 1
        sw $t1, 4($sp)
        j ifend

    else:

    ifend:
        jr $ra