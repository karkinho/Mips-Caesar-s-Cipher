.data
	menu1: .asciiz "1. Criptografar\n"
	menu2: .asciiz "2. Descriptogracifar\n"
	menu3: .asciiz "3. Sair\n" 
	askString: .asciiz "Digite a Mensagem: "
	askCypher: .asciiz "Digite o Deslocamento: "
	nextLine: .asciiz "\n" 
	string: .space 100 # String with max size of 400 character
.text

	# $t0 to $t7 will be temporary variables
	# $s0 is the string address
	# &s1 is the menu1 address
	# &s2 is the menu2 address
	# &s3 is the menu3 address
	# &s4 is the askString address
	# &s5 is the askCypher address
	# &s6 is the nextLine address
	# $s7 will be temp addresses

main: 
	la $s0 , string # string -> $s0
	la $s1 , menu1  # menu1 -> $s1
	la $s2 , menu2  # menu2 -> $s2
	la $s3 , menu3  # menu3 -> $s3
	la $s4 , askString  # askString -> $s4
	la $s5 , askCypher # askCypher -> $s5
	la $s6 , nextLine # nextLine -> %s6
	
	j menu

menu: 
	move $a0 , $s1 # print menu
	li $v0 , 4	
	syscall  	
	move $a0 , $s2	
	syscall  
	move $a0 , $s3	
	syscall  

	li $v0 , 5 # read option
	syscall  	
	
	beq $v0 , 1 , menuEncrypt
	beq $v0 , 2 , decrypt
	beq $v0 , 3 , exit
	j menu

menuEncrypt:
	move $a0 , $s4 # askString
	li $v0 , 4	
	syscall  	
	move $a0 , $s0 # readString
	li $a1 , 100
	li $v0 , 8
	syscall  	

	move $a0 , $s5 # askCypher
	li $v0 , 4	
	syscall  	
	li $v0 , 5
	syscall
	move $t0 , $v0 # $t0 has chyper
	
	j encrypt

encrypt:
	move $s7 , $s0

	move $a2 , $t0 # modulo para os numeros
	li $a3 , 10
	jal modulo
	move $t2 , $v1

	move $a2 , $t0 # modulo para as letras 
	li $a3 , 26
	jal modulo
	move $t3 , $v1

	loopEncrypt:
		li $v1 , 0
		lb $t1 , 0($s7) 
		beq $t1 , 10 , print
		beq $t1 , 0 , print
		jal isNumber
		beq $v1 , 1 , encryptNumber 
		jal isLetter
		beq $v1 , 1 , encryptLetter
		jal isLetterUpercase
		beq $v1 , 1 , encryptLetterUpercase
	
	j exit

encryptNumber:
	li $t5 , '0'
	sub $t4 , $t1 , $t5
	add $t6 , $t4 , $t2
	bge $t6 , 10 , greaterEqualencryptNumber
		add $t1 , $t1 , $t2
		sb $t1 , 0($s7)
		addi $s7 , $s7 , 1 
		j loopEncrypt
	greaterEqualencryptNumber: 
		sub $t6 , $t6 , 10
		add $t1 , $t5 , $t6
		sb $t1 , 0($s7) 
		addi $s7 , $s7 , 1
		j loopEncrypt

encryptLetterUpercase:
	li $t5 , 'A'
	sub $t4 , $t1 , $t5
	add $t6 , $t4 , $t3
	bge $t6 , 26 , greaterEqualencryptLetterUpercase
		add $t1 , $t1 , $t3
		sb $t1 , 0($s7)
		addi $s7 , $s7 , 1 
		j loopEncrypt
	greaterEqualencryptLetterUpercase: 
		sub $t6 , $t6 , 26
		add $t1 , $t5 , $t6
		sb $t1 , 0($s7) 
		addi $s7 , $s7 , 1
		j loopEncrypt


encryptLetter:
	li $t5 , 'a'
	sub $t4 , $t1 , $t5
	add $t6 , $t4 , $t3
	bge $t6 , 26 , greaterEqualencryptLetter
		add $t1 , $t1 , $t3
		sb $t1 , 0($s7)
		addi $s7 , $s7 , 1 
		j loopEncrypt
	greaterEqualencryptLetter: 
		sub $t6 , $t6 , 26
		add $t1 , $t5 , $t6
		sb $t1 , 0($s7) 
		addi $s7 , $s7 , 1
		j loopEncrypt



modulo: # modulo de $a2 pelo numero de $a3
	div $a2 , $a3
	li $a3 , 0
	li $a2 , 0
	mfhi $v1
	jr $ra


isNumber: # checks if the character a number $v1 0 if false | $v1 1 if true
	blt $t1 , '0' , isNumberFalse
	bgt $t1 , '9', isNumberFalse
	li $v1 , 1
	jr $ra
	isNumberFalse:
		li $v1 , 0 
		jr $ra	

isLetter: # checks if the character is a lower case letter $v1 0 if false | $v1 1 if true
	blt $t1 , 'a' , isLetterFalse
	bgt $t1 , 'z', isLetterFalse
	li $v1 , 1
	jr $ra
	isLetterFalse:
		li $v1 , 0
		jr $ra	

isLetterUpercase: # checks if the character is a lower case letter $v1 0 if false | $v1 1 if true
	blt $t1 , 'A' , isLetterUpercaseFalse
	bgt $t1 , 'Z', isLetterUpercaseFalse
	li $v1 , 1
	jr $ra
	isLetterUpercaseFalse:
		li $v1 , 0
		jr $ra	

print:
	move $a0 , $s0 #print String
	li $v0 , 4
	syscall
	move $a0 , $s6 
	li $v0 , 4
	syscall  
	j menu

decrypt:

exit: 	
	li $v0 , 10	
	syscall 
	
	











	
	
