.data
input_msg: .asciiz "Input integr"
output_msg: .asciiz "Sum till Given No"
error_msg: .asciiz "Number should be greater than 0"
.text
.globl main
.ent main
main:
    li $v0,4
    la $a0, input_msg
    syscall

    li $v0,5
    syscall
    move $s0, $v0

    addi $t0,$0,0                                                           #t0=index variable
    slt $t2,$t0,$s0                                                         #t2=1(if no > 0->run code), t2=0(no<0-> error)
    beq $t2,$0,err
    addi $t3,$0,0                                                           #t3 is add
loop:
    slti slt $t2,$t0,$s0                                                         #t2=1(if no > 0->run code), t2=0(no<0-> error)
    beq $t2,$0,break_loop
    add $t3,$t0,$t3                                                          #sum+=i
    addi $t0,$t0,1                                                           #updating index variable
    j loop
break_loop:
    li $v0,4
    la $a0, output_msg
    syscall
    j en


err:
    li $v0,4
    la $a0, error_msg
    syscall
    j en

en:
    jr $ra
    .end main