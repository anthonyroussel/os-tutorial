#ifndef MEM_H
#define MEM_H

#include "../cpu/types.h"

void memory_copy(char* src, char* dest, int length);
void memory_set(u8 *dest, u8 value, u32 length);

#endif
