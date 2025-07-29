global _start

section .text
_start:
	push rbp	;8 Byte decrease: We push a garbage frame onto the stack (We will call it GF)
	mov rbp, rsp	;We overwrite rbp with rsp, our new rbp frame
	sub rsp, 8	;We subtract 8 bytes from rsp, reserving space for a local variable

	mov qword [rbp-8], 420	;We utilize rbp as the memory point to access our variables
	mov rdi, [rbp-8]	;Here we can watch our variable get loaded into memory

	call func	;Calls func, which pushes the Memory address of the next function (Let's call it NFA in diagram) onto the stack
	
	mov rax, 60	;(NFA) SYSCALL exit
	mov rdi, 0	;Status 0
	syscall	;Syscall
func:
	push rbp	;8 Byte decrease: Push the value of rbp (Lets call it PBP in diagram), a pointer to the start of the previous stack frame (which holds our 420 variable), onto the stack
	mov rbp, rsp	;Move the address of rsp (not the value at the address) into rbp, the new base pointer 
	
	sub rsp, 8	;We always move in terms of 8, so push and pop dont end up at odd locations.
	
	mov byte [rbp-1], 69	;Here we assign our new variable, at [rbp-1]
	mov byte [rbp-2], 42	;New variable, [rbp-2]
	movzx rdi, byte [rbp-1]	;Loading variable [rbp-1] into rdi for viewing, movzx allows a byte to be represented in 8 byte register through zeroing
	movzx rdi, byte [rbp-2]	;Viewing [rbp-2]
	
	mov rsp, rbp	;Restore the previous value of rsp
	pop rbp	;8 Byte increase: We pop the value of rsp (Which is currently PBP) into rbp
	ret	;We pop the value of rsp (Which is currently NFA) into RIP (the next instruction registry)

;So, the stack Looks like this throughout the program
;
;Phase 0 (First Push rbp)	|1:GF|2:---|3:---|
;
;Phase 1 (call func)	|1:GF|2:NFA|3:---|
;
;Phase 2 (push rbp)	|1:GF|2:NFA|3:PBP|
;
;Phase 3 (pop rbp)	|1:GF|2:NFA|3:---|
;
;Phase 4 (ret)	|1:GF|2:---|3:---|
;
;It seems, when done correctly, we have the Garbage frame leftover
