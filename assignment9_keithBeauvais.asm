#;	Assignment #9
#; 	Author: Keith Beauvais
#; 	Section: 1001
#; 	Date Last Modified: 11/5/2021
#; 	Program Description: The program will add together dollar and cent totals and calculate the total amount.  The values are provided in the
#;  template.

.data
dollarAmounts: .word 243, 123, 113, 203, 231, 147, 113, 207, 198, 160
			  .word 177, 227, 121, 197, 208, 119, 135, 134, 230, 171
			  .word 201, 101, 200, 196, 189, 240, 201, 134, 182, 201

centAmounts: .word 27, 46, 19, 81, 20, 36, 48, 61, 86, 89
			.word 89, 47, 45, 62, 64, 34, 18, 78, 84, 10
			.word 29, 11, 22, 97, 70, 61, 2, 71, 44, 92

COUNT = 30

#;	Calculate these values
totalDollars: .space 4
totalCents: .space 4
	
#;	Labels
amountLabel: .asciiz "Total: $"
period: .asciiz "."

#;	System Services
SYSTEM_EXIT = 10
SYSTEM_PRINT_INTEGER = 1
SYSTEM_PRINT_STRING = 4	

.text
.globl main
.ent main
main:
	#; Add together dollar and cent values from the provided arrays
	#; Convert dollars to cents and add to cent total
	#; Calculate dollars and cents using division on the cent total
	#; Store results in totalDollars and totalCents

	la $t0, dollarAmounts #; dollar array address
	la $t1, centAmounts	#; cent array address
	li $t2, 0 #; sum for dollars
	li $t3, 0 #; sum for cents
	li $t7, COUNT #; count 


	arrayLoop:
	lw $t4, ($t0) #; get dollarArray 
	lw $t5, ($t1) #; get centArray
	add $t2, $t2, $t4 #; adds the sum to next amount in array (dollars)
	add $t3, $t3, $t5 #; adds the sum to next amount in array (cents)
	addu $t0, $t0, 4 #; goes to next index in array
	addu $t1, $t1, 4 #; goes to next index in array
	subu $t7, $t7, 1 #; subtracts one from the count
	bnez $t7, arrayLoop

	li $t7, 100
	mul $t2, $t2, $t7	#; multiplies the dollars by 100 to get cents
	add $t2, $t2, $t3 #; adds on the cents to dollars

	div $t0, $t2, $t7 #; divides the sum by 100 
	rem $t1, $t2, $t7	#;remainder is the cents

	sw $t0, totalDollars	#; saves into totalDollars
	sw $t1, totalCents	#; saves into totalCents

	#; Print Total Amount
	li $v0, SYSTEM_PRINT_STRING
	la $a0, amountLabel
	syscall
	
	li $v0, SYSTEM_PRINT_INTEGER
	lw $a0, totalDollars
	syscall
	
	li $v0, SYSTEM_PRINT_STRING
	la $a0, period
	syscall
	
	li $v0, SYSTEM_PRINT_INTEGER
	lw $a0, totalCents
	syscall

	li $v0, SYSTEM_EXIT
	syscall
.end main