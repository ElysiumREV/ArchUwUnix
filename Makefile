# Diretórios
BOOT_DIR = boot
KERNEL_DIR = kernel
ISO_DIR = iso

# Compilador
CC = gcc
LD = ld

# Opções de compilação
CFLAGS = -m32 -ffreestanding -O2 -fno-pie -Wall -Wextra
LDFLAGS = -m elf_i386 -T $(KERNEL_DIR)/linker.ld

# Arquivos de saída
KERNEL_BIN = $(ISO_DIR)/kernel.bin
KERNEL_ELF = $(KERNEL_DIR)/kernel.elf
BOOT_BIN = $(ISO_DIR)/boot.bin
ISO_FILE = $(ISO_DIR)/ArchUwUnix.iso

.PHONY: all clean

all: iso

# Compila o kernel
$(KERNEL_ELF): $(KERNEL_DIR)/kernel.c
	$(CC) $(CFLAGS) -c $(KERNEL_DIR)/kernel.c -o $(KERNEL_ELF)

$(KERNEL_BIN): $(KERNEL_ELF)
	$(LD) $(LDFLAGS) $(KERNEL_ELF) -o $(KERNEL_BIN)

# Compila o bootloader
$(BOOT_BIN): $(BOOT_DIR)/boot.asm
	nasm -f bin $(BOOT_DIR)/boot.asm -o $(BOOT_BIN)

# Cria a imagem ISO
iso: $(KERNEL_BIN) $(BOOT_BIN)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL_BIN) $(ISO_DIR)/boot/kernel.bin
	cp $(BOOT_BIN) $(ISO_DIR)/boot/
	echo 'set timeout=0' > $(ISO_DIR)/boot/grub/grub.cfg
	echo 'set default=0' >> $(ISO_DIR)/boot/grub/grub.cfg
	echo 'menuentry "ArchUwUnix" {' >> $(ISO_DIR)/boot/grub/grub.cfg
	echo '  multiboot /boot/kernel.bin' >> $(ISO_DIR)/boot/grub/grub.cfg
	echo '  boot' >> $(ISO_DIR)/boot/grub/grub.cfg
	echo '}' >> $(ISO_DIR)/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO_FILE) $(ISO_DIR)

clean:
	rm -rf $(KERNEL_ELF) $(KERNEL_BIN) $(BOOT_BIN) $(ISO_DIR)/boot
	rm -f $(ISO_FILE)