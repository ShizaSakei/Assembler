%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
%endmacro

%macro leer 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
%endmacro

section .data
    msj1 db "Ingrese el primer numero: "
    len1 equ $-msj1

    msj2 db "Ingrese el segundo numero: "
    len2 equ $-msj2

    mensaje db "El resultado es: "
    len equ $-mensaje
    
    salto db " ", 10
    len_salto equ $-salto

section .bss
    suma resb 1
    n1 resb 1
    n2 resb 1

section .text
    global _start

_start:
    ; Primer numero
    escribir msj1, len1

    int 80h

    leer n1, 2

    int 80h

    ; Segundo numero
    escribir msj2, len2

    int 80h

    leer n2, 2

    int 80h

    ; Proceso de suma
    mov ax, [n1]
    mov bx, [n2]

    sub ax, '0'
    sub bx, '0'

    add ax, bx
    add ax, '0'

    mov [suma], ax

    ; Imprime suma

    escribir mensaje, len

    int 80h

    escribir suma, 1

    int 80h

    escribir salto, len_salto

    int 80h

    mov eax, 1
    int 80h
