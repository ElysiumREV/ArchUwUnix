#include <stdint.h>

#define MULTIBOOT_HEADER_MAGIC 0x1BADB002
#define MULTIBOOT_HEADER_FLAGS 0x00000003

typedef struct {
    uint32_t magic;
    uint32_t flags;
    uint32_t checksum;
    uint32_t header_addr;
    uint32_t load_addr;
    uint32_t load_end_addr;
    uint32_t bss_end_addr;
    uint32_t entry_addr;
} __attribute__((packed)) multiboot_header_t;

multiboot_header_t multiboot_header __attribute__((section(".multiboot"))) = {
    MULTIBOOT_HEADER_MAGIC,
    MULTIBOOT_HEADER_FLAGS,
    -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS),
    0,
    0x1000, // Endereço onde o kernel será carregado
    0,
    0,
    0x1000  // Endereço de entrada
};

void kernel_main() {
    const char *message = "Meu Primeiro Sistema Operacional!";
    char *video_memory = (char *) 0xb8000;

    for (int i = 0; message[i] != '\0'; i++) {
        video_memory[i * 2] = message[i];      // Caractere
        video_memory[i * 2 + 1] = 0x07;        // Atributo de cor
    }

    while (1);  // Loop infinito
}