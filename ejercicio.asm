%macro escribir 2
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
    msj1 db "Ingrese el path", 10
    len1 equ $-msj1

    path db '/home/pancho/Documentos/ejercicio', 0
    len_path equ $ - path

    archivo db '/home/pancho/Documentos/ejercicio/codigo2.txt', 0

    mensaje_error db "error en el archivo", 10
    len_error equ $-mensaje_error

section .bss
    ;direc resb 60
    texto resb 35
    idarchivo resb 1

section .text
	global _start
_start:
    ;escribir msj1, len1
    ;leer direc, 60

    mov eax, 39 
    mov ebx, path
    mov ecx, 0x1FF 
    int 80h

    leer texto, 35

    mov eax, 8 ; subrutina
    mov ebx, archivo ;ruta 
    mov ecx, 1 ; acceso
    mov edx, 0x1FF ;permiso
    int 80h

    test eax, eax
    jz error

    mov dword [idarchivo], eax

    mov eax, 4
    mov ebx, [idarchivo]
    mov ecx, texto
    mov edx, 35
    int 80h

    jmp salir

error:
    escribir mensaje_error, len_error    

salir:
    mov eax, 1
    int 80h 