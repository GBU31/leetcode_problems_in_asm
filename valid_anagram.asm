section .data
    s db "anagram", 0
    t db "nagaram", 0
    s_len equ $ - s
    t_len equ $ - t
    
section .bss
    s_count resd 26
    t_count resd 26
    
section .text
    global _start
    
_start:
    xor ecx, ecx
    mov esi, s_count
    mov edi, t_count
    mov edx, 26
    rep stosd

    mov esi, s
    mov ecx, s_len
    call count_characters
    mov esi, t
    mov ecx, t_len
    call count_characters
    mov ecx, 26
    mov esi, s_count
    mov edi, t_count
compare_loop:
    mov eax, [esi]
    cmp eax, [edi]
    jne not_anagram
    add esi, 4
    add edi, 4
    loop compare_loop
    jmp anagram
    
not_anagram:
    jmp exit
    
anagram:
    ; Print "true" or perform further actions
  
    
exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
    
count_characters:
    count_loop:
        movzx eax, byte [esi]
        sub eax, 'a'
        inc dword [s_count + eax*4]
        inc esi
        loop count_loop
    ret
