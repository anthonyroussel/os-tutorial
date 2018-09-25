print_string:
  pusha

  ; int=10 / ah=0x0e -> BIOS tele-type output
  mov ah, 0x0e

loop:
  ; copy content at bx address in al
  mov al, [bx]

  ; print the character in al
  int 0x10

  ; next bx address
  add bx, 1

  ; stop if al equals \0
  cmp al, 0
  jne loop

  popa
  ret
