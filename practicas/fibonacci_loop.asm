section .data
    salto db 10,''
    len_salto equ $-salto

section .bss
    num_a resb 2
    num_b resb 2
    num_c resb 2

section .text
    global _start

_start:
    mov ebx, 0
    mov edx, 1

    add ebx, '0'
    add edx, '0'

    mov [num_a], ebx
    mov [num_b], edx
    mov [num_c], ebx

    call imprimir_numero

    mov ecx, 9

    jmp fibonacci

fibonacci:
    push ecx

    mov eax, [num_a]
    mov ebx, [num_b]
    mov ecx, [num_c]

    sub eax, '0'
    sub ebx, '0'
    sub ecx, '0'

    mov eax, ebx
    mov ebx, ecx

    mov edx, eax
    add edx, ebx
    mov ecx, edx

    add eax, '0'    
    add ebx, '0'    
    add ecx, '0'

    mov [num_a], eax
    mov [num_b], ebx
    mov [num_c], ecx

    call imprimir_numero

    pop ecx

    loop fibonacci

    jmp salida

imprimir_numero:
    mov eax, 4
    mov ebx, 1
    mov ecx, num_c
    mov edx, 1
    int 80h

    ret

salida:
    mov eax, 1
    int 80h
    