void kernel_main() {
    const char *message = "Meu Primeiro Sistema Operacional!";
    char *video_memory = (char *) 0xb8000;
    
    for (int i = 0; message[i] != '\0'; i++) {
        video_memory[i * 2] = message[i];      // Caractere
        video_memory[i * 2 + 1] = 0x07;        // Atributo de cor
    }

    while (1);  // Loop infinito
}
