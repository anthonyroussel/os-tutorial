F=boot

all: $(F).asm
	nasm $(F).asm -f bin -o $(F).bin
	qemu-system-x86_64 $(F).bin
