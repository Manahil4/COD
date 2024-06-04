#Q1
.data
    NUM1: .asciiz "THIS PROGRAM PRINTS THE AVERAGE OF THREE NUMBERS📝\nENTER FIRST NUMBER: "
    NUM2: .asciiz "ENTER SECOND NUMBER: "
    NUM3: .asciiz "ENTER THIRD NUMBER: "
    RESULT: .asciiz "THE AVERAGE OF THE THREE NUMBERS IS: "
.text
.globl main
.ent main
main:   
#_____________________________CALLER_BEGINS_____________________________#
    li $v0, 4       # Print NUM1
    la $a0, NUM1
    syscall

    li $v0, 5       # Read NUM1
    syscall
    move $a1, $v0   # num1 is moved to $a1(Argument Register)

    li $v0, 4       # Print NUM2
    la $a0, NUM2
    syscall

    li $v0, 5       # Read NUM2
    syscall
    move $a2, $v0   # num2 is moved to $a2(Argument Register)

    li $v0, 4       # Print NUM3
    la $a0, NUM3
    syscall

    li $v0, 5       # Read NUM3
    syscall
    move $a3, $v0   # num3 is moved to $a3(Argument Register)

    jal AVERAGE

    li $v0, 4       # Print RESULT
    la $a0, RESULT
    syscall

    li $v0, 1       # Print Result
    move $a0, $v1   # The result is moved from $v1(Return Value Register) to $a0
    syscall

    li $v0, 10      # For explicit exit from main
    syscall
    jr $ra

.end main
#_____________________________CALLER_ENDS_______________________________#

#_____________________________CALLEE_BEGINS_____________________________#
AVERAGE:
    add $t0, $a1, $a2       # $t0 = num1 + num2
    add $t0, $t0, $a3       # $t0 = num1 + num2 + num3
    
    slti $t2, $t0, 0        # If $t0 < 0 => add -1 else add +1
    bne $t2, $0, ADD_NEG_ONE
    addi $t0, $t0, 1        # $t0 = num1 + num2 + num3 + 1
    j ENDIF

    ADD_NEG_ONE:
        addi $t0, $t0, -1 
    
    ENDIF:
        addi $t1, $0, 3     # $t1 = 3
        div $t0, $t1        # $t0 / $t1
        mflo $v1
        jr $ra
#_____________________________CALLEE_ENDS_______________________________#


#Q2________________
.data
    msg1: .asciiz "THIS PROGRAM CALCULATES (NUMBER ^ POWER)\nENTER NUMBER: "
    msg2: .asciiz "ENTER POWER: "
    msg3: .asciiz "RESULT: "

.text
.globl main
.ent main

main:   li $v0, 4           # Print msg1
        la $a0, msg1
        syscall

        li $v0, 5           # Read NUMBER
        syscall
        move $a1, $v0       # NUMBER is moved in $a1

        li $v0, 4           # Print msg2
        la $a0, msg2
        syscall

        li $v0, 5           # Read POWER
        syscall
        move $a2, $v0       # POWER is moved in $a2

        # We haven't used any temporary registers in main -> We do not have to push any register before function call
        
        addi $sp, $sp, -4    # Push $ra
        sw $ra, 0($sp)

        jal power_calculator    # Fucntion Call

        lw $ra, 0($sp)      # Pop $ra
        addi $sp, $sp, 4

        li $v0, 4           # Print msg3
        la $a0, msg3
        syscall

        li $v0, 1          # Print Result
        move $a0, $v1
        syscall

        li $v0, 10  # For explicit exit from main
        syscall

        power_calculator:   addi $sp, $sp, -8   # Making room for 4 registers
                            sw $s0, 4($sp)      # Push $s0
                            sw $s1, 0($sp)      # Push $s1

                            addi $s0, $0, 1             # $s0 (Result) = 1
                            addi $s1, $s1, 0            # $s1 (Iterator) = 0
                            LOOP:   mult $s0, $a1       # $s0 * $a1
                                    mflo $s0            # $s0 = $s0 * $a1
                                    addi $s1, $s1, 1    # $s1 += 1
                                    bne $s1, $a2, LOOP  # If $s1 != $a2 -> Jump To Loop

                            move $v1, $s0       # Move $s0 in $v0

                            lw $s1, 0($sp)      # Pop $s1
                            lw $s0, 4($sp)      # Pop $s0
                            addi $sp, $sp, 8    # Adust SP        
                            jr $ra              # Return back
                            
        jr $ra
        .end main



#Q2( second method)
.data
    msg1: .asciiz "THIS PROGRAM CALCULATES (NUMBER ^ POWER)\nENTER NUMBER: "
    msg2: .asciiz "ENTER POWER: "
    msg3: .asciiz "RESULT: "
    ERROR: .asciiz "📌ERROR: PLEASE ENTER POSITIVE NUMBER!\n"

.text
.globl main
.ent main

main:   
#_____________________________CALLER_BEGINS_____________________________#
        li $v0, 4           # Print msg1
        la $a0, msg1
        syscall

        li $v0, 5           # Read NUMBER
        syscall
        move $a1, $v0       # NUMBER is moved in $a1

        li $v0, 4           # Print msg2
        la $a0, msg2
        syscall

        li $v0, 5           # Read POWER
        syscall
        move $a2, $v0       # POWER is moved in $a2

        slti $t0, $a2, -1
        beq $t0, $0, CALCULATE_POWER
        
        li $v0, 4           # Print ERROR
        la $a0, ERROR
        syscall
        j main          

        # We haven't used any temporary registers in main -> We do not have to push any register before function call
        CALCULATE_POWER:    jal power_calculator

        li $v0, 4           # Print msg3
        la $a0, msg3
        syscall

        li $v0, 1          # Print Result
        move $a0, $v1
        syscall

        li $v0, 10  # For explicit exit from main
        syscall
        jr $ra

.end main
#_____________________________CALLER_ENDS_______________________________#
power_calculator:   
        bne $a2, $0, CONTINUE
        addi $v1, $0, 1
        j END
                            
        CONTINUE:
                addi $sp, $sp, -8   # Making room for 4 registers
                sw $s0, 4($sp)      # Push $s0
                sw $s1, 0($sp)      # Push $s1

                addi $s0, $0, 1             # $s0 (Result) = 1 
                addi $s1, $s1, 0            # $s1 (Iterator) = 0
                LOOP:   mult $s0, $a1       # $s0 * $a1
                        mflo $s0            # $s0 = $s0 * $a1
                        addi $s1, $s1, 1    # $s1 += 1
                        bne $s1, $a2, LOOP  # If $s1 != $a2 -> Jump To Loop

                move $v1, $s0       # Move $s0 in $v1
                            
        END:
        lw $s1, 0($sp)      # Pop $s1
        lw $s0, 4($sp)      # Pop $s0
        addi $sp, $sp, 8    # Adust SP        
        jr $ra              # Return back
                            
        
