# Manipulate an array from user input
# "Welcome to Array Manipulator v1.0"
# "To start array input please enter array size: [size]"
# "Enter element [n]: [u]"
# "What do you want to do with the array?"
# "1. Sort."
# "2. Compute sum of elements."
# "3. Find greatest element."
# "4. Quit."
# "Action: [u]"
# "Result: [r]"
# "Bye!"

.data
	introMessage:  .asciiz "Welcome to Array Manipulator v1.0 \nTo start array input please enter array size: "
	elementEnterA: .asciiz "Enter element "
	elementEnterB: .asciiz ": "
	programMenu:   .asciiz "What do you want to do with the array? \n1. Sort. \n2. Compute sum of elements. \n3. Find greatest element. \n4. Quit. \nAction: "
	resultOutput:  .asciiz "Result: "
	newLine:       .asciiz "\n\n"
	exitMessage:   .asciiz "Bye!"
	

.text
	# size-0($sp),array-4($sp),i-8($sp),sum-12($sp),max-16($sp)
	subiu $sp,$sp,20

	main:
		# print Intro Message
		la $a0,introMessage
		li $v0,4
		syscall
	
		# store user input into ($t0),(0($sp))
		li $v0,5
		syscall
		move $t0,$v0	# This ($t0) is size
		sw $t0,0($sp)
		
		# dynamically allocate array into ($t1),(4($sp))
		mul $a0,$t0,4
		li $v0,9
		syscall
		
		# initialize variables
		move $t1,$v0	# This ($t1) is array.
		sw $t1,4($sp)
		li $t2,0		# This ($t2) is i.
		sw $t2,8($sp)
		li $t3,0		# This ($t3) is sum
		sw $t3,12($sp)
		li $t4,0		# This ($t4) is max
		sw $t0,16($sp)
		
	inputloop:
		# break loop if i>=length ($t2>=$t0)
		bge $t2,$t0,sort
		
		# print Element Enter A
		la $a0,elementEnterA
		li $v0,4
		syscall
		# print i
		move $a0,$t2
		li $v0,1
		syscall
		# print Element Enter B
		la $a0,elementEnterB
		li $v0,4
		syscall
		
		# get user input
		li $v0,5
		syscall
		
		# move user input into array
		# $t5,$t6,$t7 are temp for array
		move $t5,$v0		# store input in $t5
		mul $t6,$t2,4		# $t6 is index = i*4
		addu $t7,$t1,$t6	# $t7 is array+index
		sw $t5,($t7)		# store input in array
		addiu $t2,$t2,1		# i++
		sw $t2,8($sp)		# store array
		
		# add input to sum
		add $t3,$t3,$t5
		sw $t3,12($sp)
		
		# if max>=input,skip code
		bge $t4,$t5,inputloopelse
		move $t4,$t5
		sw $t4,16($sp)
		inputloopelse:
		
		# loop back
		j inputloop

	sort: 
		lw $a0,0($sp) # pass array length to sort
		lw $a1,4($sp) # pass array to sort
		jal quicksort # call sort

	menu:
		# print Program Menu
		la $a0,programMenu
		li $v0,4
		syscall
		
		# store user input to ($t0)
		li $v0,5
		syscall
		move $t0,$v0
		
		# if u=1 goto sorted
		beq $t0,1,sorted
		# if u=2 goto sum
		beq $t0,2,sum
		# if u=3 goto greatest
		beq $t0,3,greatest
		# if u=4 quit
		beq $t0,4,end
		
	sorted: li $t0,0
		lw $t1,4($sp)
		lw $t2,0($sp)
		# print Result Output
		la $a0,resultOutput
		li $v0,4
		syscall
		sortedloop: bge $t0,$t2,sortedend
			lw $t3,0($t1)
			addi $t1,$t1,4
		
			# print number
			li $v0,1
			move $a0,$t3
			syscall
			# print space
			li $a0,32
			li $v0,11
			syscall
		
			addi $t0,$t0,1
			j sortedloop
		sortedend:
			# print New Line
			la $a0,newLine
			li $v0,4
			syscall
			# goto menu
			j menu
		
	sum:
		# print Result Output
		la $a0,resultOutput
		li $v0,4
		syscall
		# print sum
		lw $a0,12($sp)
		li $v0,1
		syscall
		# print New Line
		la $a0,newLine
		li $v0,4
		syscall
		# goto menu
		j menu
		
	greatest:
		# print Result Output
		la $a0,resultOutput
		li $v0,4
		syscall
		# print sum
		lw $a0,16($sp)
		li $v0,1
		syscall
		# print New Line
		la $a0,newLine
		li $v0,4
		syscall
		# goto menu
		j menu
	end:	
		# print Exit Message
		la $a0,exitMessage
		li $v0,4
		syscall
		li $v0,10
		syscall

	# quicksort and helper methods here
	quicksort:
		add $s3,$0,$a1		# saving array address
	sortloop:
		# create 4: 0-return,4-n,8-array,12,i
		subiu $sp,$sp,16	# create space
		sw $ra,0($sp) 		# store return addr
		sw $a0,4($sp) 		# n
		sw $a1,8($sp) 		# array
		sw $t0,12($sp)		# $t0 is i
		li $t0,0		# i=0
		subiu $t1,$a0,1		# $t1 is j
		add $t2,$t0,$t1 	# $t2 is i+j
		div $t2,$t2,2		# (i+j)/2
		mul $t2,$t2,4		# 2(i+j)
		add $t3,$a1,$t2		# $t3 is address: array+2(i+j)
		lw $t4,0($t3)		# $t4 is pivot value: array[$t3]
	sortwhile:
		bgt $t0,$t1,sortafterif	# while i<=j
	sortwhilei:
		mul $t5,$t0,4		# $t5 = i*4
		add $t8,$t5,$a1		# $t8=array[$t5]
		lw $t5,0($t8)		# load $t5
		bge $t5,$t4,sortwhilej	# if $t5>=$t4 goto sortwhilej
		add $t0,$t0,1		# i++
		j sortwhilei
	sortwhilej:
		mul $t6,$t1,4		# $t6 = j*4
		add $t9,$t6,$a1		# $t9=array[$t6]
		lw $t6,0($t9)		# load $t6
		ble $t6,$t4,sortif	# if $t6>=$t4 goto sortif
		sub $t1,$t1,1		# j--
		j sortwhilej
	sortif:
		bgt $t0,$t1,sortafterif	# if (i>=j) skip
		sw $t6,0($t8)		# set $t6 to array[j]
		sw $t5,0($t9)		# set $t5 to array[i]
		add $t0,$t0,1		# i++
		sub $t1,$t1,1		# j--
		j sortwhile
	sortafterif:
		sw $t0 , 12($sp)	# store i
	quicksortreq:
		ble $t1,0,quicksortreqif 
		add $a0,$t1,1		# set recursive call argument
		jal quicksort
	quicksortreqif:
		lw $a0,4($sp)		# set recursive call argument $a0 to n
		lw $t0,12($sp)		# set recursive call argument $t0 to i
		sub $t7,$a0,1		# set $t7 to n-1
		bge $t0,$t7,endsort	# base case
		mul $s2,$t0,4		# set $s2 to i*4
		add $a1,$a1,$s2		# change recursive call argument $a0 by i*4
		sub $a0,$a0,$t0		# change recursive call argument $a0 n = n-i
		jal quicksort
	endsort:
		lw $ra,0($sp)		# set return address
		lw $a0,4($sp)		# return n
		lw $a1,8($sp)		# return array
		lw $t0,12($sp)		# return i
		add $sp,$sp,16		# close memory
		jr $ra
