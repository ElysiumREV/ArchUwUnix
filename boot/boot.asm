section .text
    global _start

_start:
    ; Carrega o kernel
    mov bx, 0x9000         ; Segmento de memória para carregar o kernel
    mov dh, 15             ; Número de setores para carregar
    mov dl, 0x00           ; Drive (0x00 para o disco)
    int 0x13               ; Chamada de interrupção para carregar

    ; Salta para o endereço do kernel
    jmp 0x9000:0x0000      ; Vai para o kernel carregado na memória
