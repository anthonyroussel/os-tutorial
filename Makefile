# $@ = target file
# $< = first dependency
# $^ = all dependencies
#
# First rule is the one executed when no parameters are fed to the Makefile
all: run

# bootsector
boot.bin: boot.asm
	nasm $< -f bin -o $@

# kernel
kernel.bin: kernel_entry.o kernel.o
	ld -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	gcc -fno-pie -m32 -ffreestanding -c $< -o $@

# os image
os-image.bin: boot.bin kernel.bin
	cat $^ > $@

# utils
run: os-image.bin
	qemu-system-x86_64 -fda $<

clean:
	rm -f *.bin *.o
