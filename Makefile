# $@ = target file
# $< = first dependency
# $^ = all dependencies
#
C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c libc/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h libc/*.h)
# Nice syntax for file extension replacement
OBJ = ${C_SOURCES:.c=.o cpu/interrupt.o}

#
CC := gcc
CFLAGS += -g -ffreestanding -Wall -Wextra -fno-exceptions -m32 -fno-pie
LD := ld
LDFLAGS += -m elf_i386
GDB := gdb

# First rule is the one executed when no parameters are fed to the Makefile
all: os-image.bin

# os image
os-image.bin: boot/boot.bin boot/kernel.bin
	cat $^ > $@

# kernel
boot/kernel.bin: boot/kernel_entry.o ${OBJ}
	${LD} ${LDFLAGS} -o $@ -Ttext 0x1000 $^ --oformat binary

boot/kernel.elf: boot/kernel_entry.o ${OBJ}
	${LD} ${LDFLAGS} -o $@ -Ttext 0x1000 $^

# Generic rules for wildcards
# To make an object, always compile from its .c
%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@

# Open the connection to qemu and load our kernel-object file with symbols
# qemu is invoked with debugging options
# * see https://en.wikibooks.org/wiki/QEMU/Invocation
debug: os-image.bin boot/kernel.elf
	qemu-system-x86_64 -s -drive format=raw,file=$<,index=0,if=floppy -d guest_errors,int &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file boot/kernel.elf"

# utils
run: os-image.bin
	qemu-system-x86_64 -drive format=raw,file=$<,index=0,if=floppy

clean:
	@rm -f */*.bin */*.o */*.elf *.bin
