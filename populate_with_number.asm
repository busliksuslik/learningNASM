section .bss
    array resb 1024
   
section .text
    global _start
_start:
    xor al,al       ;set al to zero
    mov edi, array  ; set edi to start of array
    mov ecx, 1024   ; set ecx to size of array
    cld             ; set direction flag (DF) to ascending order (clear direction)
    mov al, 20
    rep  stosb           ; a.k.a. mov [edi], al ; inc edi

    
end_program:
    mov	eax,1       ;system call number (sys_exit)
    int	0x80        ;call kernel

section .data
    array_cp db "Hello World", 0xa, 0x0
    len equ $ - array_cp     ;length of the string