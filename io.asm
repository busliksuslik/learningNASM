%include "helpers.inc"
global printf

section .bss
    printf_output resb 1024
   
section .text
    global _start
_start:
    mov rax, 0x56

end_program:
    exit 0

printf:
    push ebp
    mov ebp, esp

    push esi        ;saving registers for caller
    push edi
    push ecx

    mov esi, [arg1]

    push 20h
    push esi
    call strlen
    add esp, 8
    mov ecx, eax

.lp:
    cmp byte esi, '%'
    je special






.quit:              ; return registers to initaial state
    pop ecx
    pop edi
    pop esi

    mov esp, ebp
    pop ebp
    ret

strlen:
    push ebp
    mov ebp, esp    ;saving stack to return to caller

    push esi        ;saving registers for caller
    push ecx

    mov esi, [arg1]   ;geting arguments from stack
    mov ecx, [arg2]

.lp:
    cmp byte [esi], 0x0     ; edi = 0
    je .finish
    inc esi
    loop .lp        ; ecx != 0; ecx--
    jmp .false
.finish:
    mov eax, [arg2]
    sub eax, ecx
    jmp .quit
.false:
    mov eax, 0x0
.quit
    pop ecx
    pop esi
    mov esp, ebp
    pop ebp
    ret



section .data
    array_cp db "Hello World", 0xa, 0x0
    len equ $ - array_cp     ;length of the string