; ENSAMBLADO PARA INGRESO POR TECLADO
section .data
    mensaje db "Ingreso de palabra: "
    len_msg equ $-mensaje

section .bss
    nombre resb 5
    len equ $-nombre

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, len_msg

    int 80h

    mov eax, 3 ; Operacion o definicion del servicios (3: lectura, 4: escritura)
    mov ebx, 2 ; E/S (1: pantalla, 2: teclado)
    mov ecx, nombre ; Almacena la ref a memoria de la variablr
    mov edx, len ; Max num de caracteres

    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, nombre
    mov edx, len

    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, 10
    mov edx, 1

    int 80h

    mov eax, 1 ; Servicio de salida 
    int 80h ; Instruccion de interrupcion