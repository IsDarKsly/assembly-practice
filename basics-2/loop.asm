global _start

section .text
_start:
	mov rax, 5	;sets rax with arbitrary value
	cmp rax, 60	;compares rax with 0 and sets a corresponding flag somewhere
	jne loop	;jumps if the flag is not equal
loop:
	add rax, 1	;increment rax by 1
	cmp rax, 60	;compare rax to 60 again
	jne loop	;if not 60, jump to loop
	syscall		;Syscall occurs when we reach 60, ending the applications
