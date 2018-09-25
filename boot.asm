[org 0x7c00]
  mov bx, BOOTING_MSG
  call print_string

  jmp $

BOOTING_MSG:
  ; db stands for "declare bytes"
  ; and write directly into binary output file
  db 'Booting OS...', 0

%include "print_string.asm"

; bios magic number
times 510-($-$$) db 0
dw 0xaa55
