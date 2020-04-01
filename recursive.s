.data
  max_input: .space 100
  not_valid: .asciiz "Input Invalid"
  too_large: .asciiz "too large"
.text
  main:
     #taking the user input for hexadecimal numbers
      li $v0, 8
