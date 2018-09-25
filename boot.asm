[org 0x7c00]
  ; print booting message
  mov bx, BOOTING_MSG
  call print_string

  ; wait indefinitely
  jmp $

; file inclusions
; ===============
%include "functions/print_string.asm"
%include "functions/cls.asm"

; data
; ====
BOOTING_MSG:
  ; db stands for "declare bytes"
  ; and write directly into binary output file
  db 'Booting OS...', 0


; bios magic number
; =================
times 510-($-$$) db 0
dw 0xaa55

; disk data
; =========
times 256 dw 0xdada
times 256 dw 0xface
