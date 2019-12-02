section .data
    msj db 'Desplegar los asteriscos 9 veces'
    len equ $ - msj
    asterisco times 9 db 10,'*'
    len_asteristo equ $ - asterisco

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msj
    mov edx, len

    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, asterisco
    mov edx, len_asteristo

    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, 10
    mov edx, 1

    int 80h

    mov eax, 1

    int 80h