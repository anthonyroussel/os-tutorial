F=boot
SOURCE=$(F).asm
BIN=$(F).bin

all: $(BIN) run

$(BIN): $(SOURCE)
	nasm $(SOURCE) -f bin -o $(BIN)

run:
	 qemu-system-x86_64 -curses -drive format=raw,file=$(BIN)
