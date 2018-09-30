#ifndef IDT_H
#define IDT_H

/** inspired from
 * http://www.jamesmolloy.co.uk/tutorial_html/4.-The%20GDT%20and%20IDT.html
 */
#include <stdint.h>

/* Segment selectors */
#define KERNEL_CS 0x08
#define IDT_ENTRIES 256

/* How every interrupt gate (handler) is defined */
typedef struct {
  /* The lower 16 bits of the address to jump to when this interrupt fires */
  uint16_t low_offset;
  /* Kernel segment selector. */
  uint16_t sel;
  /* This must always be zero */
  uint8_t always0;
  /* More flags, see documentation */
  /* First byte
   * Bit 7: "Interrupt is present"
   * Bits 6-5: Privilege level of caller (0=kernel..3=user)
   * Bit 4: Set to 0 for interrupt gates
   * Bits 3-0: bits 1110 = decimal 14 = "32 bit interrupt gate"
   */
  uint8_t flags;
  /* The upper 16 bits of the address to jump to */
  uint16_t high_offset;
} __attribute__((packed)) idt_gate_t;

/* Pointer to an array of interrupt handlers.
 * Assembly instruction 'lidt' will read it */
typedef struct {
  uint16_t limit;
  /* Address of the first element in our idt_gate_t array */
  uint32_t base;
} __attribute__((packed)) idt_register_t;

/* implemented functions */
void set_idt_gate(int n, uint32_t handler);
void set_idt();

#endif
