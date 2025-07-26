For the first set of basics, I will be observing the actions of the Registers.

After close observation using GDB, RIP registry contains the address of the currently executed instruction.
System Calls seem to be operating System Specific, with x86-64 Assembly on linux using "Syscall" with and RAX of 60 to indicate a "exit" syscall

Older versions, like 32 bit assembly on linux use "int 0x80" to signify a Syscall, and takes a code of 1 in EAX (the 32 bit version of RAX) as the "exit" system call.
  
