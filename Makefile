# Diretórios
BOOT_DIR = boot
KERNEL_DIR = kernel
ISO_DIR = iso

# Compilador
CC = gcc
LD = ld

# Opções de compilação
CFLAGS = -m32 -ffreestanding -fno-pic -O2 -Wall -Wextra
LDFLAGS =  -m elf_i386 -Ttext 0x1000 --oformat binary -e kernel_main

# Arquivos de saída
KERNEL_BIN = $(ISO_DIR)/kernel.bin
KERNEL_ELF = $(KERNEL_DIR)/kernel.elf
ISO_FILE = $(ISO_DIR)/ArchUwUnix.iso

.PHONY: all clean

all: iso

# Compila o kernel
$(KERNEL_BIN): $(KERNEL_DIR)/kernel.c
	$(CC) $(CFLAGS) -c $(KERNEL_DIR)/kernel.c -o $(KERNEL_ELF)
	$(LD) $(LDFLAGS) $(KERNEL_ELF) -o $(KERNEL_BIN)

# Cria a imagem ISO
iso: $(KERNEL_BIN)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL_BIN) $(ISO_DIR)/boot/kernel.bin
	echo 'set timeout=0' > $(ISO_DIR)/boot/grub/grub.cfg
	echo 'set default=0' >> $(ISO_DIR)/boot/grub/grub.cfg
	echo 'menuentry "ArchUwUnix" {' >> $(ISO_DIR)/boot/grub/grub.cfg
	echo '  multiboot /boot/kernel.bin' >> $(ISO_DIR)/boot/grub/grub.cfg
	echo '  boot' >> $(ISO_DIR)/boot/grub/grub.cfg
	echo '}' >> $(ISO_DIR)/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO_FILE) $(ISO_DIR)

clean:
	rm -rf $(KERNEL_ELF) $(KERNEL_BIN) $(ISO_DIR)/boot
	rm -f $(ISO_FILE)