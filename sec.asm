.data
	msg1: .asciiz "Enter First no followed by enter"
	msg2: .asciiz "\n Second"
	msg3: .asciiz "\n result"

.text
.global main
.ent main
main:
	li $v0, 4
	la $a0, msg1
	syscall
	li $v0, 5
	syscall
	move $t1, $v0

	li $v0,4
	la $a0, msg2
	syscall

	li $v0,5
	syscall
	move $t2, $v0
	
	add $t3, $t1, $t2

	li $v0,4 
	la $a0, msg3
	syscall

	li $v0,1 
	move $a0, $t3
	syscall
	
	jr $ra
.end main