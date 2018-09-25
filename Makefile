F=boot

all: $(F).bin run

$(F).bin: $(F).asm
	nasm $(F).asm -f bin -o $(F).bin

run:
	 qemu-system-x86_64 -curses -drive format=raw,file=$(F).bin
