#include "../cpu/isr.h"
#include "../cpu/timer.h"
#include "../drivers/keyboard.h"
#include "../drivers/screen.h"

void kernel_main() {
  clear_screen();
  kprint("DixieOS\n\n");

  isr_install();

  asm volatile("sti");
  init_timer(50);
  /* Comment out the timer IRQ handler to read
   * the keyboard IRQs easier */
  init_keyboard();
}

