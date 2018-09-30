#include "mem.h"

void memory_copy(char *source, char *dest, int length) {
  int i;
  for (i = 0; i < length; i++) {
    *(dest + i) = *(source + i);
  }
}

void memory_set(u8 *dest, u8 value, u32 length) {
  u8 *temp = (u8*) dest;
  for (; length != 0; length--) {
    *temp++ = value;
  }
}
