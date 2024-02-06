section .data
    array dd 2, 7, 11, 15
    target dd 9
    array_len equ ($ - array) / 4

    result_str db "Indices of the 2 nums: ", 0xA
    result_len equ $ - result_str

    newline db 0xA
    newline_len equ 1

section .bss
    indices_buffer resb 2

section .text
    global _start

_start:
    mov ecx, array_len

outer_loop:
    dec ecx
    test ecx, ecx
    jz not_found

    mov eax, ecx
    mov edx, array 

inner_loop:
    mov ebx, [edx + eax * 4]
    add ebx, [array]
    cmp ebx, [target]
    je found
    dec eax
    jnz inner_loop

    jmp outer_loop

found:
    mov ebx, [edx + eax * 4]
    add ebx, [array]
    sub ebx, [target]
    mov eax, ecx 
    mov edx, eax

    mov eax, 4
    mov ebx, 1
    mov ecx, result_str
    mov edx, result_len
    int 0x80

    mov eax, ecx
    add eax, '0'
    mov [indices_buffer], al
    inc eax
    mov [indices_buffer + 1], al

    mov eax, 4
    mov ebx, 1
    mov ecx, indices_buffer
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 1
    int 0x80

    mov eax, edx
    add eax, '0'
    mov [indices_buffer], al
    inc eax
    mov [indices_buffer + 1], al

    mov eax, 4
    mov ebx, 1
    mov ecx, indices_buffer
    mov edx, 2
    int 0x80

    mov eax, 4           
    mov ebx, 1           
    mov ecx, newline    
    mov edx, newline_len 
    int 0x80             

    jmp exit_program

not_found:
    mov ebx, 0

exit_program:
    mov eax, 1
    int 0x80
