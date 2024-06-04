.data
msg1:   .asciiz "THIS PROGRAM CALCULATES (NUMBER ^ POWER)\nENTER NUMBER: "
msg2:   .asciiz "ENTER POWER: "
msg3:   .asciiz "RESULT: "
ERROR:  .asciiz "📌ERROR: PLEASE ENTER NON-NEGATIVE POWER!\n"

.text
.globl main
.ent main

main:
    # Print msg1
    li $v0, 4
    la $a0, msg1
    syscall
    
    # Read NUMBER
    li $v0, 5
    syscall
    move $a1, $v0  # NUMBER is moved to $a1
    
    # Print msg2
    li $v0, 4
    la $a0, msg2
    syscall
    
    # Read POWER
    li $v0, 5
    syscall
    move $a2, $v0  # POWER is moved to $a2
    
    # Check if POWER is non-negative
    bltz $a2, print_error  # If POWER < 0, go to print_error
    
    # Calculate power
    jal power_calculator
    
    # Print msg3
    li $v0, 4
    la $a0, msg3
    syscall
    
    # Print result
    li $v0, 1
    move $a0, $v1  # Result from power_calculator is in $v1
    syscall
    
    # Exit program
    li $v0, 10
    syscall

print_error:
    # Print ERROR message
    li $v0, 4
    la $a0, ERROR
    syscall
    
    # Jump back to start
    j main

power_calculator:
    # Base case: if POWER is 0, return 1
    bnez $a2, calculate_power  # If POWER is not zero, jump to calculate_power
    li $v1, 1  # If POWER is zero, result is 1
    jr $ra     # Return to main

calculate_power:
    addi $sp, $sp, -8  # Make room on stack
    sw $s0, 4($sp)     # Save $s0 on stack
    sw $s1, 0($sp)     # Save $s1 on stack

    li $s0, 1          # Initialize result to 1
    move $s1, $zero    # Initialize iterator to 0

loop:
    mul $s0, $s0, $a1  # Multiply $s0 by NUMBER
    addi $s1, $s1, 1   # Increment iterator
    bne $s1, $a2, loop # Loop until iterator equals POWER

    move $v1, $s0  # Move result to $v1

end:
    lw $s1, 0($sp)     # Restore $s1
    lw $s0, 4($sp)     # Restore $s0
    addi $sp, $sp, 8   # Adjust stack pointer
    jr $ra             # Return to main
