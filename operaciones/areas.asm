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


; SEGMENTOS DE CODIGO
section .data
    ; constantes
    mensaje db "OPERACIONES CON FIGURAS", 10, 09, "1. Area del cuadrado", 10, 09, "2. Area del circulo", 10, 09, "3. Area del rectangulo", 10
    len equ $-mensaje

    opciones db "Elija una opcion: "
    len_opciones equ $-opciones

    msj_resultado db "El resultado es: "
    len_resultado equ $-msj_resultado

    msj_cuadrado db ">> AREA DEL CUADRADO <<",10
    len_msj_cua equ $-msj_cuadrado

    msj_circulo db ">> AREA DEL CIRCULO <<",10
    len_msj_cir equ $-msj_circulo

    num_lado db "Ingrese un lado del cuadrado: "
    len_num_lado equ $-num_lado

    num_radio db "Ingrese el radio del circulo: "
    len_num_radio equ $-num_radio

    msj_rectangulo db ">> AREA DEL RECTANGULO <<",10
    len_msj_rec equ $-msj_rectangulo

    num_base db "Ingrese la base del rectangulo: "
    len_num_base equ $-num_base

    num_altura db "Ingrese la altura del rectangulo: "
    len_num_altura equ $-num_altura

    salto db " ", 10
    len_salto equ $-salto


section .bss
    ; variables
    lado resb 1
    radio resb 1
    base resb 1
    altura resb 1
    resultado resb 1
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
        je area_cuadrado

    cmp ah, 2
        je area_circulo

    cmp ah, 3
        je area_rectangulo

    jmp salida

area_cuadrado:
    imprimir msj_cuadrado, len_msj_cua

    imprimir num_lado, len_num_lado
    leer lado, 2

    multiplicacion [lado], [lado]

    imprimir msj_resultado, len_resultado
    imprimir resultado, 1

    imprimir salto, len_salto

    jmp salida

area_circulo:
    imprimir msj_circulo, len_msj_cir

    imprimir num_radio, len_num_radio
    leer radio, 2

    multiplicacion [radio], [radio]
    multiplicacion [resultado], '3' ; se envia la parte entera de la constante pi

    imprimir msj_resultado, len_resultado
    imprimir resultado, 1

    imprimir salto, len_salto

    jmp salida

area_rectangulo:
    imprimir msj_rectangulo, len_msj_rec

    imprimir num_base, len_num_base
    leer base, 2

    imprimir num_altura, len_num_altura
    leer altura, 2

    multiplicacion [base], [altura]

    imprimir msj_resultado, len_resultado
    imprimir resultado, 1

    imprimir salto, len_salto

    jmp salida

salida:
    mov eax, 1
    int 80h

