section .bss
    array_pp resb 256
   
section .text
    global _start
_start:
    
end_program:
    mov	eax,1       ;system call number (sys_exit)
    int	0x80        ;call kernel

section .data
    array_cp db "Hello World", 0xa, 0x0
    len equ $ - array_cp     ;length of the string