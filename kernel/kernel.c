#include "../drivers/screen.h"
#include "util.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"

void main() {
  clear_screen();
  kprint("DixieOS\n\n");

  isr_install();
  asm volatile("int $0x2");
  asm volatile("int $0x3");
}

