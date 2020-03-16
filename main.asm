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

section .data
    archivo_entrada db "/home/deusvult/Documentos/Assembler/practica_post_prueba/texto.txt",0

    ruta db "/home/deusvult/Escritorio/prueba", 0
    archivo_salida db "/home/deusvult/Escritorio/prueba/resultado.txt", 0

    salto db "",10

    msj_err db "¡Error en el archivo!",10
    lenerror equ $- msj_err

section .bss
    idarchivo resb 1
    text resb 30
    txt_out resb 1

section .text
    global _start

_start:
    mov eax, 5
    mov ebx, archivo_entrada
    mov ecx, 0
    mov edx, 0
    int 80h

    test eax, eax 
    jz err

    mov dword [idarchivo], eax

    mov eax, 3
    mov ebx, [idarchivo] ; aquí vinculamos el archivo
    mov ecx, text
    mov edx, 30
    int 80h
    
    mov eax, 6
    mov ebx, [idarchivo]
    mov ecx, 0
    mov edx, 0

    mov esi, text
    mov edi, 0

    jmp imprimir_arreglo

imprimir_arreglo:
    mov al, [esi]

    call restar_uno

    mov [txt_out], al
    mov [esi], al

    add esi, 1
    add edi, 1

    imprimir txt_out, 2
    imprimir salto, 1

    cmp edi, 9
    jb imprimir_arreglo

    jmp escribir_salida

escribir_salida:
    mov esi, text
    mov edi, 0
    
    mov eax, 39
    mov ebx, ruta
    mov ecx, 0x1FF
    int 80h

    mov eax, 8
    mov ebx, archivo_salida
    mov ecx, 1  ; acceso
    mov edx, 0x1FF ; permiso
    int 80h

    test eax, eax; verifica la direccion establecido hace un testeo de la subrutina
    jz err

    mov dword [idarchivo], eax

    mov eax, 4
	mov ebx, [idarchivo]
	mov ecx, esi
	mov edx, 30
	int 80h

    jmp salir

restar_uno:
    sub al, '0'
    sub al, 1
    add al, '0'

    ret

err:
    imprimir msj_err, lenerror

salir:
    mov eax, 1
    int 80h