; Transformar de numero a cadena se suma "0" -> add registro, "0"
; Transformar de numero a cadena se resta "0"

section .data
    mensaje db "El resultado es: ", 10
    len equ $-mensaje

section .bss
    suma resb 1

section .text
    global _start

_start:
    mov eax, 2
    mov ebx, 4
    
    add eax, ebx
    add eax, '0'

    mov [suma], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, len

    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, suma
    mov edx, 2

    int 80h

    mov eax, 1
    int 80h
