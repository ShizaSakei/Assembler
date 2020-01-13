; je -> salto de comparacion de igualdad
; cmp -> instruccion de comparacion

; MACROS
%macro imprimir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro leer 2
    mov eax, 3
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro resta 2
    mov ax, %1
    mov bx, %2

    sub ax, '0'
    sub bx, '0'

    sub ax, bx
    add ax, '0'

    mov [residuo], ax

    int 80h
%endmacro

%macro suma 2
    mov ax, %1
    mov bx, %2

    sub ax, '0'
    sub bx, '0'

    add ax, bx
    add ax, '0'

    mov [cociente], ax

    int 80h
%endmacro

; SEGMENTOS DE CODIGO
section .data
    ; constantes
    mensaje db "DIVISION POR RESTA REPETIDA", 10
    len equ $-mensaje


    num_one db "Ingrese el primer numero: "
    len_num_one equ $-num_one

    num_two db "Ingrese el segundo numero: "
    len_num_two equ $-num_two

    msj_div db ">> DIVISION <<",10
    len_msj_div equ $-msj_div

    msj_cociente db "Cociente: "
    len_msj_co equ $-msj_cociente

    msj_residuo db "Residuo: "
    len_msj_re equ $-msj_residuo

    salto db " ", 10
    len_salto equ $-salto

section .bss
    ; variables
    n1 resb 1
    n2 resb 1
    cociente resb 1
    residuo resb 1

section .text
    global _start

_start:
    ; codigo principal
    imprimir mensaje, len

    imprimir num_one, len_num_one
    leer n1, 2

    imprimir num_two, len_num_two
    leer n2, 2

    resta [n1],'0'
    
    jmp dividir

; ETIQUETAS
division:
    resta [residuo],[n2]
    suma [cociente],'1'
    jmp dividir

dividir:
    mov ax, [residuo]
    mov bx, [n2]

    sub ax, '0'
    sub bx, '0'

    cmp ax,bx
    jg division
    je division

    jmp presentar

presentar:
    imprimir msj_cociente, len_msj_co
    imprimir cociente, 1

    imprimir salto, len_salto

    imprimir msj_residuo, len_msj_re
    imprimir residuo, 1

    imprimir salto, len_salto

    jmp salida

salida:
    mov eax, 1
    int 80h

