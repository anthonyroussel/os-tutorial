print:
  ; Push registers onto the stack
  pusha

string_loop:
  ; Set al to the value at bx
  mov al, [bx]
  ; Compare the value in al to 0 (check for null terminator)
  cmp al, 0
  ; If it's not null, print the character at al
  ; Otherwise the string is done, and the function is ending
  jne print_char
  ; Pop all the registers back onto the stack
  popa
  ; Return execution to where we were
  ret

print_char:
  ; Linefeed printing
  mov ah, 0x0e
  ; Print character
  int 0x10
  ; Shift bx to the next character
  add bx, 1
  ; Go back to the beginning of our loop
  jmp string_loop
