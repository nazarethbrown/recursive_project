.data
  max_input: .space 100
  not_valid: .asciiz "Input Invalid"
  too_large: .asciiz "too large"
.text
  main:
     #taking the user input for hexadecimal numbers
      li $v0, 8
      la $a0,  max_input
      li $a1, 1001
      syscall 

     #loading the input to a  register for conversion to decimal 
      la $s0, max_input 
      li $s1, 0     #start pointer
      li $s2, 0     #end pointer

     word_list:
       la $s1, ($s2)

     substring: 
       add $t1, $s0, $s2 	#iterator 
       lb $t2, 0($t1) 		#loading the current character 
       
       # a few criteron to exit the loop while iterating the substrings 
       beq $t2, 0, end_substring
       beq $t2, 10, end_substring
       beq $t2, 44, end_substring


