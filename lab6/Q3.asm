.data

input_msg: .asciiz "Enter Integer"
comp_msg: .asciiz "No is composite"
prime_msg: .asciiz "Prime"
error_msg: .asciiz " No should greatter than 0, int are from 0 to infinite"
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

    addi $t0,$0,1                                                           #t0=factor
    addi $t1,$0,0                                                           #t1=0
    slt $t2,$t1,$s0                                                         #t2=1(if no > 0->run code), t2=0(no<0-> error)
    beq $t2,$0,err

    addi $t3,$0,2
    div $s0,$t3
    mflo $t3                                                                #now t3 contains  n/2

loop: 
    slt $t2, $t1,$t3                                                    #t1 acts as index variable, check t1 is less than n/2
    beq $t2,$0,break_loop                                               #t2=1( t1 index variable is less than n/2),t2=0(t1 index variable is not less than n/2)
    div $s0,$t1
    mflo $t4                                                            #t4 contains remainder of n/i
    beq $t4,$0,add_in_fact                                              # checking n is divisible by i
    addi $t1,$t1,1
    j loop

add_in_fact:
    addi $t0,$0,1
    li $v0,4
    la $a0, comp_msg
    syscall
    j en
break_loop:
    li $v0,4
    la $a0, prime_msg
    syscall
    j en

err:
    li $v0,4
    la $a0, error_msg
    syscall
    


en:
    jr $ra
.end main
#.data
; input_msg: .asciiz "Enter Integer"
; comp_msg: .asciiz "No is composite"
; prime_msg: .asciiz "Prime"
; error_msg: .asciiz "Number should be greater than 0; integers range from 0 to infinite"

; .text
; .globl main
; .ent main
; func:
;     li $v0, 4
;     la $a0, input_msg
;     syscall

;     li $v0, 5
;     syscall
;     move $s0, $v0

;     addi $t0, $0, 1         # t0=factor
;     addi $t1, $0, 0         # t1=0
;     slt $t2, $t1, $s0       # t2=1(if no > 0->run code), t2=0(no<0-> error)
;     beq $t2, $0, error

;     addi $t3, $0, 2
;     div $s0, $t3
;     mflo $t3                # now t3 contains n/2

; loop:
;     slt $t2, $t1, $t3            # t1 acts as index variable, check t1 is less than n/2
;     beq $t2, $0, break_loop      # t2=1( t1 index variable is less than n/2), t2=0(t1 index variable is not less than n/2)
;     div $s0, $t1
;     mflo $t4                    # t4 contains remainder of n/i
;     beq $t4, $0, add_in_fact    # checking n is divisible by i
;     addi $t1, $t1, 1
;     j loop

; add_in_fact:
;     addi $t0, $0, 1
;     li $v0, 4
;     la $a0, comp_msg
;     syscall
;     j end

; break_loop:
;     li $v0, 4
;     la $a0, prime_msg
;     syscall
;     j end

; error:
;     li $v0, 4
;     la $a0, error_msg
;     syscall
;     j func

; end:
;     jr $ra

; .end main
