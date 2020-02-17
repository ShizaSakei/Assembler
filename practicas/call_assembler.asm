section .data
    asterisco db '*'
    nueva_linea db 10,''

section .bss
    contador_bx resb 1
    contador_cx resb 1

section .text
    global _start

_start:
    mov ecx, 9

    jmp l1

l1:
    push ecx

    call imprimir_linea

    pop ecx
    push ecx

l2:
    push ecx
    call imprimir_asterisco
    pop ecx

    loop l2

    pop ecx

    loop l1

    jmp salir

imprimir_linea:
    mov eax, 4
    mov ebx, 1
    mov ecx, nueva_linea
    mov edx, 1
    int 80h

    ret

imprimir_asterisco:
    mov eax, 4
    mov ebx, 1
    mov ecx, asterisco
    mov edx, 1
    int 80h

    ret

salir:
    mov eax, 1
    int 80h