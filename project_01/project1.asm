.text
subiu $sp, $sp, 4 #space for n at 0($sp)
main:
    li $t0, 0 #$t0 is n
    sw $t0, 0($sp) #store n
    li $t1, 5 #argument
    # n-0($sp), ra-4($sp), return-8($sp)
    subiu $sp, $sp, 12 #create space
    sw $t1, 0($sp) #init n to $t1
    sw $ra, 4($sp) #init ra to $ra
    jal facto_rec #call function
    lw $t0, 8($sp) #returned value
    lw $ra, 4($sp) #return address ra
    addiu $sp, $sp, 12 #close memory
    sw $t0, 0($sp) #store n
    #print n
    move $a0, $t0
    li $v0, 1
    syscall
    #exit gracefully
    li $v0, 10
    syscall
facto_rec:
    lw $t0, 0($sp) #load n
    bgt $t0, 1, else #if n>1 goto else
    #execute if n<=1
    li $t1, 1 #sets $t1 to 1
    sw $t1, 8($sp) #stores 1 in return address
    j ifend #goes to ifend to return 8($sp)
else:    sub $t2, $t0, 1 #set $t2 to n-1
    subiu $sp, $sp, 12 #create space again
    sw $t2, 0($sp) #set n to n-1
    sw $ra, 4($sp) #return address
    jal facto_rec #function call with n=$t2
    lw $t3, 8($sp) #returned recursive value
    lw $ra, 4($sp) #return address
    addiu $sp, $sp, 12 #close memory
    lw $t0, 0($sp) #set $t0 to n
    mul $t4, $t3, $t0 #set $t4 to facto_rec(n-1)*n
    sw $t4, 8($sp) #stores result in 8($sp), code automatically goes to ifend
ifend: jr $ra #return