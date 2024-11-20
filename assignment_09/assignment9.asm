.text

    subiu $sp, $sp, 4 #space for int z: 0($sp)

    main:

        li $t0, 0

        sw $t0, 0($sp)

        li $t1, 35

        li $t2, 7

        # 5 words

        # x-0, result-4, y-8, ra-12, return-16

        subiu $sp, $sp, 20

        sw $t1, 0($sp)

        sw $ra, 12($sp)

        jal addxy

        lw $t2, 16($sp)

        lw $ra, 12($sp)

        addiu $sp, $sp, 20

        lw $t2, 0($sp)

        move $t2, $a0

        #print z

        li $v0, 1

        syscall

        #exit gracefully

        li $v0, 10

        syscall

 

    addxy:

        li $t0, 1

        sw $t0, 4($sp) #t0 -> result

        li $t1, 2

        sw $t1, 8($sp) # t1 -> y

        lw $t2, 0($sp) # t2 -> x

        add $t0, $t1, $t2 # result = x+y

        sw $t0, 16($sp)

        jr $ra