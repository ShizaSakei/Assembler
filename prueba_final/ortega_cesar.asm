%macro imprimir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    ; Direccion del archivo
    archivo_entrada db "/home/deusvult/Documentos/Assembler/prueba_final/ortega_cesar.txt",0
    
    ; Mensaje de error
    m_error db "¡Error en el archivo!",10
    len_error equ $-m_error

    ; Mensajes de resultado
    msj_repite db " se repite "
    len_msj_repite equ $-msj_repite

    msj_suma db "La suma de todos los numeros es: "
    len_msj_suma equ $-msj_suma

    ; Cadena para almacenar la suma
    suma db "  "
    len equ $-suma

    ; Salto de linea
    salto db "",10

section .bss
    id_archivo resb 1
    text resb 20

    ; Variables auxiliares
    num_actual resb 1
    contador resb 1

section .text
    global _start

_start:
    mov eax, 5
    mov ebx, archivo_entrada
    mov ecx, 0
    mov edx, 0
    int 80h

    test eax, eax 
    jz error_archivo

; Etiqueta de lectura del archivo
; e inicializacion de valores
inicializar:
    mov dword [id_archivo], eax

    mov eax, 3
    mov ebx, [id_archivo]
    mov ecx, text
    mov edx, 30
    int 80h
    
    mov eax, 6
    mov ebx, [id_archivo]
    mov ecx, 0
    mov edx, 0

    ; se inician los valores del arreglo
    mov esi, text
    mov edi, 0
    
    ; contadores
    mov cl, 0
    mov dl, 0

    jmp comparar

; Etiqueta de error en el archivo
error_archivo:
    imprimir m_error, len_error
    jmp salida

reiniciar_valores:
    inc dl
    mov esi, text
    mov edi, 0    
    mov cl, 0

    ret
; Etiqueta de comparación
comparar:
    mov al, [esi]
    sub al, '0'

    add esi, 1
    add edi, 1

    cmp al, dl
    je sumar_uno

    cmp edi, 20
    jb comparar

    jmp verificar_resultado

; Suma si encuentra coincidencia
sumar_uno:
    inc cl

    cmp edi, 20
    jb comparar

; Imprime si el conteo es mayor a cero
verificar_resultado:
    cmp cl, 0
    jg imprimir_resultado

    call reiniciar_valores

    cmp dl, 9
    jng comparar

    clc

    jmp sumar_arreglo

; Imprime el resultado del conteo
imprimir_resultado:
    push dx

    add dl, '0'
    mov [num_actual], dl

    add cl, '0'
    mov [contador], cl

    imprimir num_actual, 1
    imprimir msj_repite, len_msj_repite
    imprimir contador, 1
    imprimir salto, 2

    pop dx
    
    call reiniciar_valores

    cmp dl, 9
    jng comparar

    clc

    jmp sumar_arreglo

; Suma del arreglo de numeros
sumar_arreglo:
    mov al, [suma + 1]
    mov ah, [esi]

    sub ah, '0'

    adc al, ah

    aaa
    pushf
    or al, 30h
    popf

    mov [suma + 1], al

    mov al, [suma + 0]
    mov ah, 0

    adc al, ah

    aaa
    pushf
    or al, 30h
    popf

    mov [suma + 0], al

    add esi, 1
    add edi, 1

    cmp edi, 20
    jb sumar_arreglo

    imprimir msj_suma, len_msj_suma
    imprimir suma, 2
    imprimir salto,2

    jmp salida

salida:
    mov eax, 1
    int 80h