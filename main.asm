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
	
	beq $v0 , 1 , encrypt
	beq $v0 , 2 , decrypt
	beq $v0 , 3 , exit
	j menu

encrypt:
	move $a0 , $s4 # askString
	li $a1 , 400
	li $v0 , 4	
	syscall  	
	move $a0 , $s0 # readString
	li $v0 , 8
	syscall  	

	move $a0 , $s5 # askCypher
	li $v0 , 4	
	syscall  	
	li $v0 , 5
	syscall
	move $t0 , $v0 # $t0 has chyper

	# call

decrypt:
	move $a0 , $s4 # askString
	li $a1 , 400
	li $v0 , 4	
	syscall  	
	move $a0 , $s0 # readString
	li $v0 , 8
	syscall  	

	move $a0 , $s5 # askCypher
	li $v0 , 4	
	syscall  	
	li $v0 , 5
	syscall
	move $t0 , $v0 # $t0 has chyper

	# call

exit: 	
	li $v0 , 10	
	syscall 
	
	











	
	