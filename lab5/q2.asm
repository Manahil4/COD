.data
# Define messages for output
msg1: .asciiz "Enter temperature of the day:  "  # Prompt for user input
msg2: .asciiz "It is hot today"                  # Message for hot weather
msg3: .asciiz "Pleasant weather"                 # Message for pleasant weather
msg4: .asciiz "It is cold today"                 # Message for cold weather

.text
.globl main
.ent main

main:
    # Display prompt message to enter temperature
    li $v0, 4                                   # Prepare syscall for printing string
    la $a0, msg1                                # Load address of msg1 into $a0
    syscall                                     # Execute syscall to print the string

    # Read integer input from user
    li $v0, 5                                   # Prepare syscall for reading integer
    syscall                                     # Execute syscall to read integer
    move $s0, $v0                               # Move the input value to $s0 ($s0 input temperature)

    # Compare input temperature with 30
    li $s1, 30                                  # Load comparison value 30 into $s1

    slt $s3, $s0, $s1                           # Set $s3 to 1 if $s0 < $s1, else 0
    li $s4, 1                                   # Load 1 into $s4

    # Branch based on comparison result
    beq $s3, $s4, TRUE_check_less_than20        # If $s0 < 30, jump to TRUE_check_less_than20
    beq $s0, $s1, print_m3                      # If $s0 = 30, jump to print_m3

    # Print "It is hot today"
    li $v0, 4                                   # Prepare syscall for printing string
    la $a0, msg2                                # Load address of msg2 into $a0
    syscall                                     # Execute syscall to print the string
    j END                                       # Jump to END

TRUE_check_less_than20:
    li $s5, 20                                  # Load comparison value 20 into $s5

    slt $s6, $s0, $s5                           # Set $s6 to 1 if $s0 < 20, else 0

    beq $s6, $s4, True_else  # If $s0 < 20, jump to True_else
    j print_m3                                  # Otherwise, jump to print_m3

print_m3:
    # Print "Pleasant weather"
    li $v0, 4                                   # Prepare syscall for printing string
    la $a0, msg3                                # Load address of msg3 into $a0
    syscall                                     # Execute syscall to print the string
    j END                                       # Jump to END

True_else:
    # Print "It is cold today"
    li $v0, 4                                   # Prepare syscall for printing string
    la $a0, msg4                                # Load address of msg4 into $a0
    syscall                                     # Execute syscall to print the string

END:
    jr $ra                                      # Jump back to return address
    .end main                                   # End of main function
