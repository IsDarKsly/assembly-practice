global _start

section .text
_start:
	call func
	syscall

func:
	mov eax, 60
	ret
