global _start

section .text
_start:
	mov rdi, 5	;Sets up rdi with value of 5
	call func	;Calls func, which pushes the Memory address of the next function (Let's call it NFA in diagram) onto the stack
	mov rax, 60	;SYSCALL exit
	mov rdi, 0	;Status 0
	syscall	;Syscall
func:
	push rbp	;Push the value of rbp (Lets call it PBP in diagram), a pointer to the start of the previous stack frame, onto the stack
	mov rbp, rsp	;Move the address of rsp (not the value at the address) into rbp, the new base pointer 
	add rdi, 5	;Some arbitrary command to fill space
	pop rbp	;We pop the value of rsp (Which is currently PBP) into rbp
	ret	;We pop the value of rsp (Which is currently NFA) into RIP (the next instruction registry)

;So, the stack Looks like this throughout the program
;
;Phase 0 (Pre call)	|1:---|2:---|
;
;Phase 1 (call func)	|1:NFA|2:---|
;
;Phase 2 (push rbp)	|1:NFA|2:PBP|
;
;Phase 3 (pop rbp)	|1:NFA|2:---|
;
;Phase 4 (ret)	|1:---|2:---|
