.data
# Define messages for output
msg1: .asciiz "Enter some integer value:  "     # Prompt for user input
msg2: .asciiz "The number is Even"              # Message for even number
msg3: .asciiz "The number is Odd"               # Message for odd number

.text
.globl main
.ent main

main:
    # Print the prompt message
    li $v0, 4                                   # Load syscall code for printing string
    la $a0, msg1                                # Load address of msg1 into $a0
    syscall                                     # Execute syscall to print the string

    # Read integer input from user
    li $v0, 5                                   # Load syscall code for reading integer
    syscall                                     # Execute syscall to read integer
    move $t0, $v0                               # Move the input value to $t0

    # Check if the input number is even or odd
    li $s0, 2                                   # Load divisor 2
    div $t0, $s0                                # Divide input value by 2
    mfhi $t1                                    # Move the remainder to $t1

    # Branch based on remainder
    beq $t1, $zero, print_Even                  # If remainder is 0, jump to print_Even

    #incase of number is odd
    li $v0, 4                                   # Load syscall code for printing string
    la $a0, msg3                                # Load address of msg3 into $a0
    syscall                                     # Execute syscall to print the string
    j End                                       # Jump to End

print_Even:
    li $v0, 4                                   # Load syscall code for printing string
    la $a0, msg2                                # Load address of msg2 into $a0
    syscall                                     # Execute syscall to print the string

End:
    jr $ra               # Jump back to return address
    .end main            # End of main function
