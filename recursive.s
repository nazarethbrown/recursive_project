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

      #Increasing the count of the iterator 
       add $s2, $s2, 1
       j substring

   end_substring:
       	#toading arguments to make a subprogram_2 call 
      la $a0, ($s1)
      la $a1, ($s2)
      
       #calling subprogram2 using jump-and-link 
      jal subprogram_2

      #calling subprogram3 using jump-and-link 
      jal subprogram_3

  #note: the return values of the subprogram2 stays in the stack which is used by the subprogram3 

      #ending the strings with end character and newline character
      beq $t2, 0, end_wl 
      beq $t2, 10, end_wl

      addi $s2, $s2, 1 	# $s2 += 1

            #formatting the print values with comma
      li $v0, 11
      li $a0, 44
      syscall
      j word_list
end_wl:
     #This following set of lines is to end the program 
      li $v0, 10 
      syscall 


      subprogram_2:
      la $s7, ($ra)	#loading the value from $ra to register $s7
      la $t9, ($a0)	#loading the value from $a0 to register $t9
      

      addi $t8, $a1, 0 #storing the end address
            la $t7, max_input  #loading the first address of the user input 

#In the following clear_front and clear_back, I am trying to remove the spaces from the front and the back of the string 
      clear_front: 
         beq $t9, $t8, end_deletion  #exiting the loop 
         add $t6, $t7, $t9			
          lb $t5, ($t6)
      #keep looping if there is still space 
       beq $t5, 32, addup 
                beq $t5, 9, addup
                j clear_back #clearing the spaces from the end if the current char is not a space. 
            addup: 
                addi $t9, $t9, 1 
                j clear_front

