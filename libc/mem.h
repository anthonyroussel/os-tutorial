#ifndef MEM_H
#define MEM_H

#include <stdint.h>
#include "../cpu/types.h"

void memory_copy(char* src, char* dest, int length);
void memory_set(uint8_t *dest, uint8_t value, uint32_t length);

#endif
