.data
input_msg: .asciiz "Factorial Calculator\nInput a Number between 0 and 13:"
result_msg: .asciiz "Factorial of given no is :"
error_msg: .asciiz "Please Input a Number between 0 and 13!"
.text
.globl main
.ent main
main:
    li $v0,4
    la $a0, input_msg
    syscall
    li $v0,5
    syscall
    move $a1, $v0
    li $t0,0
    li $t1,13
    slti $t2,$a0,$t0        #if n <0 then t2=1 else t2=0(want n is not <0)
    slti $t3, $a0, $t1       #if n< 13 so t3=1(want n<13) else t3=0
    xor $t4, $t2,$t3        #only at t2=0 and t3 =1 , t4=1
    bne $t4,$0, Fact_dec        #if t4 !=0 (means 1 ) goto Fact function
    li $v0,4
    la $a0, error_msg
    syscall
    j main

Fact_dec:
    jal cal_Fact
    li $v0,4
    la $a0, result_msg
    syscall
    li $v0,1
    move $a0,$v1
    syscall
    li $v0,10
    syscall

    jr $ra
    .end main
cal_fact:
    beq $a1,$0,BaseCondition
    addi $sp,$sp,-8
    sw $ra,0($sp)
    sw $a1, 4($sp)          #push out ra and a1 before manipulating and further function calling
    
    addi $a1,$a1,-1
    
    jal cal_fact
    lw $a1,4($sp)
    lw $ra,0($sp)
    addi $sp,$sp,8                             #pop out $ra and $a1
    
    mult $a1, $v1
    mflo $v1
    j END


BaseCondition:
    addi $v1,$0,1
    
END:
    jr $ra
