# Author: Reamohetse Ntilane
# A program reads reads and determines first 10 reversible prime squares.
.text

    main1:
        	addi $s0,$zero,0
        	addi $s1,$zero,1
        	addi $s2,$zero,0
        	addi $s3,$zero,0

        
    while:
             
        	bgt $s0,10,exit
                    
        	move $a0,$s1                # Set up an arguments and call findReverse
        	jal findReverse         
        	move $s5,$v0       
                    
        	move $a0,$s1                # Set up an arguments and call isPerfect 
        	jal isPerfect
                    
        	addi $t0,$zero,1          
        	bne $v1,$t0,increment       # increament if the return value does not equal one
            
		addi $sp,$sp,-4             # allocate memory in the stack for register $t0
		sw $t0,0($sp)       
        	move $a0,$s5                # Set up an arguments and call isPerfect agin
        	jal isPerfect
		lw $t0,0($sp)               # load $t0 back from memory
		addi $sp,$sp,4              # deallocate memory from the stack
                    
        	bne $v1,$t0,increment       # increament if the return value does not equal one
                    
        	move $a0,$s1                # Set up arguments and call root 
        	jal root
        	move $s2,$v0                # store the return value in $s2
                    
        	move $a0,$s5                # Set up arguments and call root again
        	jal root
        	move $s3,$v0                # store the return value in $s2
                    
        	move $a0,$s2
        	jal isPrime
        	move $t2,$v0
                    
        	bne $t2,1,increment
                    
        	move $a0,$s3
        	jal isPrime
        	move $t2,$v0
                    
        	move $a0,$s1
        	jal palindrome
        	move $t3,$v0
        	bne $t3,0,increment1
                    
        	# print integer
        	move $a0,$v0
        	lw $v0,1
		syscall
                    
        	# print newline
        	li $v0,4
        	la $a0,newline            
        	syscall
                
    increment1:
        	addi $s0,$s0,1
        	increment2:
        	addi $s1,$s1,1    
        	j while
                
	exit: 
        	li $v0,4
        	la $a0,message
        	syscall
                 
                
        	#Exit program
        	li $v0,10
        	syscall 
            
    findReverse: 
        
        	li $t0,0
            
    findReverse_while:
        	beq $a0,0,findReverse_getValue
                
        	mul $t1, $t0, 10      
        	addi $t2,$zero,10    # Store 10 in $t2
        	div $t2,$a0,$t2      
        	mfhi $t3             # Save remainder in $t3               
        	add $t0,$t3,$t1
                
        	div $a0,$a0,10
        	j findReverse_while     
        
	findReverse_getValue:
      		move $v0,$t0
        	
             

	isPerfect:
        	li $t0,1
            
	isPerfect_loop:
        	mul $t1,$t0,$t0
        	# find remainder
        	add $t2,$zero,$t0
        	div $t2,$a0,$t2
        	mfhi $t3              # move remainder in $t3
                
        	div $t4,$a0,$t0
             bgt $t1,$a0,isPrime_getvalue1
        	bne $t3,$zero,increment
        	bne $t4,$t0,increment
		li $v0,1
		j isPerfect_loop 
            
	increment:
        	addi $t0,$t0,1
                
      isPrime_getValue1:          # returns 0 i.e false
		li $v1,0 
	
        	                        
                    
	isPrime:
        	li $t0,2
        
	  	add $t1,$zero,$t0
        	div $t1,$t0,$t1
        	mfhi $t2

        	bgt $a0,1,isPrime_loop
        	li $v0,0           
        	jr $ra
          
	isPrime_loop:
        	bgt $t0,$a0,isPrime_getValue
        	bnez $t2,isPrime_getValue
        	li $v0,0
        	addi $t0,$zero,1
        	j isPrime_loop

     	isPrime_getValue:        
        	li $v0,1        
        	jr $ra
                    
	palindrome: 
            li $t0,0
            add $t1,$zero,$a0
	palindrome_while:
		beq $a0,0,palindrome_getValue1
		addi $t2,$zero,10
            div $t2,$a0,$t2
            mfhi $t3
        
            mul $t4,$t0,10
            add $t0,$t4,$t3
            move $a0,$t3
            j palindrome_while
                       
	palindrome_getValue1:           # returns true i.e 1
            bne $t1,$t0,palindrome_getValue2 
		li $v0,1
            jr $ra
                
    	palondrome_getValue2:           # returns false i.e 0
		li $v1,0           
            jr $ra 
        
      # a procedure to find a square root   
	root:
            li $t0,0
		add $t1,$zero,$a0
            div $t2,$a0,2
	root_loop:
        	bgt $t0,$t2,getValue
        	div $t3,$a0,$t1
        	add $t4,$t1,$t3
        	div $t1,$t4,2
        	addi $t0,$zero,1
        	j root_loop
	root_getValue:
        	move $v0,$t1
        	jr $ra
                       
.data
    newline: .asciiz "\n"
    message: .asciiz "Completed!! "
    
