section .bss
    array_pp resb 256
   
section .text
    global _start
_start:
    push dword string
    push dword sample
    
    call match
    add esp, 8

end_program:
    mov	eax,1           ; system call number (sys_exit)
    int	0x80            ; call kernel

match:
    push ebp            ; we are pushing ebp in stack, so we can be returned to this after subprogram call
    mov ebp, esp        ; copy pointer to arguments to base pointer
    sub esp, 4          ; allocate local variables in stack (stack grows in decending order of addresses)

    push esi            ; saving esi and edi because we have to return them unchanged to caller
    push edi

    mov esi, [ebp+8]    ; moving arguments to 
    mov edi, [ebp+12]

.again                  ; return here after matching symbol
    cmp byte [edi], 0   ; does sample end
    jne .not_end        ; if not jump to not_end
    cmp byte [esi], 0   ; does string end
    jne .false          ; If edi is 0 nd esi is not string and sample do not match
    jmp .true           ; otherwise two empty strings match return True
.not_end
    cmp byte [edi], '*' ; Is symbol in sample is *
    jne .not_star       ; If not jump to not star

    mov dword [ebp-4], 0 ; other wise local i := 0
.star_loop
    mov eax, edi
    inc eax 
    push eax            ; push sample from next symbol
    mov eax, esi 
    add eax, [ebp-4] 
    push eax            ; push string + local i

    call match

    add esp, 8          ; clean stack
    test eax, eax       ; test output of call
    jnz .true           ; if true jump to .true

    add eax, [ebp-4]    ; eax := i

    cmp byte [esi+eax], 0; check 
    je .false           ; if zero jump to false (string ends)
    inc dword [ebp-4]   ; i++
    jmp .star_loop      ; proceed loop 
.not_star
    mov al, [edi]
    cmp al, '?'
    je .question

    cmp al, [esi]
    jne .false
    jmp .next

.question
    cmp byte [esi], 0
    jz .false
.next
    inc esi
    inc edi
    jmp .again
.true
    mov eax, 1
    jmp .quit
.false
    mov eax,0
    jmp .quit
.quit
    pop edi
    pop esi
    mov esp, ebp
    pop ebp
    ret

section .data
    string db "Hello World", 0xa, 0x0
    sample db "*o?Wp", 0