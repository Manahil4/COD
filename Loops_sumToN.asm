Q1:

.data

msg1: .asciiz "THIS PROGRAM PRINTS THE SUM OF N INTEGERS\n\nENTER THE VALUE OF N: "

msg2: .asciiz "SUM TILL N (1+2+3+...+n) = "

error_msg: .asciiz "\nERROR: PLEASE ENTER A POSITIVE INTEGER!\n\n"

.text

.globl main

.ent main

main:

li $v0, 4 # Display prompt to enter the value of N

la $a0, msg1

syscall

li $v0, 5 # Get integer input for N

syscall

move $s0, $v0

slti $t0, $s0, 0 # Check if N is negative

bne $t0, $0, ERROR

# Initialize loop variables

addi $t0, $0, 1 # Index variable for the loop (t0 = 1)

addi $t1, $0, 0 # Variable to store the sum of integers (t1)

addi $s0, $s0, 1 # Increment N by 1 for the loop termination

LOOP: # Loop to calculate the sum of integers from 1 to N

beq $t0, $s0, EXIT # Exit the loop when t0 == N

add $t1, $t1, $t0 # Add t0 to the sum

addi $t0, $t0, 1 # Increment t0 by 1 for the next iteration

j LOOP # Jump back to LOOP

EXIT: # Display the sum of integers

li $v0, 4

la $a0, msg2

syscall

li $v0, 1

move $a0, $t1

syscall

j END

ERROR: # Display error message for negative input

li $v0, 4

la $a0, error_msg

syscall

j main

END: # End of the program

jr $ra

.end main
