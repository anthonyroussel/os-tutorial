#ifndef MEM_H
#define MEM_H

#include <stdint.h>
#include "../cpu/types.h"

void memory_copy(uint8_t *src, uint8_t *dest, int length);
void memory_set(uint8_t *dest, uint8_t value, uint32_t length);
uint32_t kmalloc(uint32_t size, int align, uint32_t *phys_addr);

#endif
