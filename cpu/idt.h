#ifndef IDT_H
#define IDT_H

/** inspired from
 * http://www.jamesmolloy.co.uk/tutorial_html/4.-The%20GDT%20and%20IDT.html
 */
#include "types.h"

/* Segment selectors */
#define KERNEL_CS 0x08
#define IDT_ENTRIES 256

/* How every interrupt gate (handler) is defined */
typedef struct {
  /* The lower 16 bits of the address to jump to when this interrupt fires */
  u16 low_offset;
  /* Kernel segment selector. */
  u16 sel;
  /* This must always be zero */
  u8 always0;
  /* More flags, see documentation */
  /* First byte
   * Bit 7: "Interrupt is present"
   * Bits 6-5: Privilege level of caller (0=kernel..3=user)
   * Bit 4: Set to 0 for interrupt gates
   * Bits 3-0: bits 1110 = decimal 14 = "32 bit interrupt gate"
   */
  u8 flags;
  /* The upper 16 bits of the address to jump to */
  u16 high_offset;
} __attribute__((packed)) idt_gate_t;

/* Pointer to an array of interrupt handlers.
 * Assembly instruction 'lidt' will read it */
typedef struct {
  u16 limit;
  /* Address of the first element in our idt_gate_t array */
  u32 base;
} __attribute__((packed)) idt_register_t;

/* implemented functions */
void set_idt_gate(int n, u32 handler);
void set_idt();

#endif
