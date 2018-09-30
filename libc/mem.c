#include <stdint.h>
#include "mem.h"

void memory_copy(uint8_t *source, uint8_t *dest, int length) {
  int i;
  for (i = 0; i < length; i++) {
    *(dest + i) = *(source + i);
  }
}

void memory_set(uint8_t *dest, uint8_t value, uint32_t length) {
  uint8_t *temp = (uint8_t*) dest;
  for (; length != 0; length--) {
    *temp++ = value;
  }
}
