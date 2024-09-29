.section .multiboot
    .align 4
    .long 0x1BADB002  # Magic number
    .long 0x00        # Flags (sem flags especiais)
    .long -(0x1BADB002 + 0x00)  # Checksum

section .text
    global _start

_start:
    cli                     ; Desative interrupções
    ; Defina o segmento de dados
    mov ax, 0x7C0          ; Carregue o endereço do setor de boot
    mov ds, ax             ; Configure DS
    mov es, ax             ; Configure ES

    ; Carregar o kernel
    mov si, kernel_start   ; Endereço do início do kernel
    mov bx, 0x1000         ; Endereço onde o kernel será carregado
    mov cx, kernel_size    ; Tamanho do kernel
    rep movsb              ; Copie os bytes do kernel para a memória

    ; Inicie o kernel
    jmp 0x1000             ; Salte para o kernel

section .bss
kernel_start:
    resb 0x2000            ; Reservar espaço para o kernel
kernel_size equ $ - kernel_start
