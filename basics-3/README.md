For this section, I will be exploring the nature of the stack and calls to functions, observing how they interact in GDB
Our initial code looked like this:

global _start

section .text
_start:
        push 1
        push 2
        push 3
        push 4
        push 60
        pop rax
        syscall

It was rather interesting to watch as the memory incremented in RSP. When using the command:
x [address], I was able to find all the values we were pushing onto the stack.
Next, we implemented an official function using "call"

global _start

section .text
_start:
        call func
        syscall

func:
        mov eax, 60
        ret

This was very interesting! When the "call" occured, we pushed the next instruction address (syscall) onto the stack before jumping to func, which then moved the value 60 before popping the value of RSP into RIP, which essentially returned us to where we were at before. I'll definitely try to explore this a little more, as most calls I see also make use of rbp, which has something to do with local variables in a given function
