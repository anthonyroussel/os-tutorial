#ifndef UTIL_H
#define UTIL_H

#include "../cpu/types.h"

void memory_copy(char* src, char* dest, int length);
void memory_set(u8 *dest, u8 value, u32 length);
void int_to_ascii(int n, char* str);

#endif
