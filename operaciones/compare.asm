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

%macro suma 2
    mov ax, %1
    mov bx, %2

    sub ax, '0'
    sub bx, '0'

    add ax, bx
    add ax, '0'

    mov [resultado], ax

    int 80h
%endmacro

%macro resta 2
    mov ax, %1
    mov bx, %2

    sub ax, '0'
    sub bx, '0'

    sub ax, bx
    add ax, '0'

    mov [resultado], ax

    int 80h
%endmacro

%macro multiplicacion 2
    mov al, %1
    mov bl, %2

    sub ax, '0'
    sub bl, '0'

    mul bl

    add al, '0'
    add ah, '0'

    mov [resultado], ax

    int 80h
%endmacro

%macro division 2
    mov al, %1
    mov bl, %2

    sub ax, '0'
    sub bl, '0'

    div bl

    add al, '0'
    add ah, '0'

    mov [cociente], al
    mov [residuo], ah

    int 80h
%endmacro

; SEGMENTOS DE CODIGO
section .data
    ; constantes
    mensaje db "OPERACIONES BASICAS DE 8 BITS", 10, 09, "1. Suma", 10, 09, "2. Resta", 10, 09, "3. Multiplicacion", 10, 09, "4. Division", 10
    len equ $-mensaje

    opciones db "Elija una opcion: "
    len_opciones equ $-opciones

    msj_resultado db "El resultado es: "
    len_resultado equ $-msj_resultado

    num_one db "Ingrese el primer numero: "
    len_num_one equ $-num_one

    num_two db "Ingrese el segundo numero: "
    len_num_two equ $-num_two

    msj_suma db ">> SUMA <<",10
    len_msj_sum equ $-msj_suma

    msj_resta db ">> RESTA <<",10
    len_msj_res equ $-msj_resta

    msj_mul db ">> MULTIPLICACION <<",10
    len_msj_mul equ $-msj_mul

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
    resultado resb 1
    cociente resb 1
    residuo resb 1
    opcion resb 1

section .text
    global _start

_start:
    ; codigo principal
    imprimir mensaje, len
    imprimir opciones, len_opciones
    leer opcion, 2
    
    mov ah, [opcion]
    sub ah, '0'

    cmp ah, 1
        je sumar

    cmp ah, 2
        je restar

    cmp ah, 3
        je multiplicar

    cmp ah, 4
        je dividir

    jmp salida

; ETIQUETAS
sumar:
    imprimir msj_suma, len_msj_sum

    imprimir num_one, len_num_one
    leer n1, 2

    imprimir num_two, len_num_two
    leer n2, 2

    suma [n1], [n2]

    imprimir msj_resultado, len_resultado
    imprimir resultado, 1

    imprimir salto, len_salto

    jmp salida

restar:
    imprimir msj_resta, len_msj_res

    imprimir num_one, len_num_one
    leer n1, 2

    imprimir num_two, len_num_two
    leer n2, 2

    resta [n1], [n2]

    imprimir msj_resultado, len_resultado
    imprimir resultado, 1

    imprimir salto, len_salto

    jmp salida

multiplicar:
    imprimir msj_mul, len_msj_mul

    imprimir num_one, len_num_one
    leer n1, 2

    imprimir num_two, len_num_two
    leer n2, 2

    multiplicacion [n1], [n2]

    imprimir msj_resultado, len_resultado
    imprimir resultado, 1

    imprimir salto, len_salto

    jmp salida

dividir:
    imprimir msj_div, len_msj_div

    imprimir num_one, len_num_one
    leer n1, 2

    imprimir num_two, len_num_two
    leer n2, 2

    division [n1], [n2]

    imprimir msj_resultado, len_resultado

    imprimir salto, len_salto

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

