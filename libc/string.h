#ifndef STRING_H
#define STRING_H

#include "../cpu/types.h"

void int_to_ascii(int n, char* str);
void reverse(char* str);
int strlen(char* str);
void append(char* str, char n);
void backspace(char* str);
int strcmp(char* s1, char* s2);

#endif
