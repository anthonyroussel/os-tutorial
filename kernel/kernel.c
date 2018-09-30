#include "../cpu/isr.h"
#include "../cpu/timer.h"
#include "../drivers/keyboard.h"
#include "../drivers/screen.h"

void kernel_main() {
  clear_screen();
  kprint("DixieOS\n\n");

  isr_install();
  irq_install();

}

