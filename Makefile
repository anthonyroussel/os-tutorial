F=boot
SOURCE=$(F).asm
BIN=$(F).bin

all: $(BIN) run

$(BIN): $(SOURCE)
	nasm $(SOURCE) -f bin -o $(BIN)

run:
	 qemu-system-x86_64 -curses -drive format=raw,file=$(BIN)

mbr: $(BIN)

kernel:
	gcc -ffreestanding -c kernel.c -o kernel.o
	ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary

image: mbr kernel
	cat $(BIN) kernel.bin > os-image.img
