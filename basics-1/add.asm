global _start

section .text
_start:
	mov rax, 3	;Primary generic register, used for return values and system call checks
	add rax, 4	;Operations typically execute as: operation [operand1, ...] with operand1 being the destination of the data
	sub rax, 6	;Brings our rax down to 1

	mov rax, 60	;Before our system call, move 60 (syscall for stop) into rax	
	mov rbx, 42	;Moves 42 into rbx register
	syscall 	;functionally the same as int 0x80. Invokes a system call
