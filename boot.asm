; Read some sectors from the boot disk using our disk_read function
[org 0x7c00]
  call cls

  ; BIOS stores our boot drive in DL, so it's
  ; best to remember this for later.
  mov [BOOT_DRIVE], dl

  ; Here we set our stack safely out of the way, at 0x8000
  mov bp, 0x8000
  mov sp, bp

  ; Load 5 sectors to 0x0000(ES):0x9000(BX) from the boot disk.
  mov bx, 0x9000
  mov dh, 5
  mov dl, [BOOT_DRIVE]
  call read_disk

  ; wait indefinitely
  jmp $

; file inclusions
; ===============
%include "functions/print_string.asm"
%include "functions/print_hex.asm"
%include "functions/read_disk.asm"
%include "functions/cls.asm"

; data
; ====
BOOTING_MSG:
  ; db stands for "declare bytes"
  ; and write directly into binary output file
  db 'Booting OS...', 0

BOOT_DRIVE: db 0

; bios magic number
; =================
times 510-($-$$) db 0
dw 0xaa55

; disk data
; =========
times 256 dw 0xdada
times 256 dw 0xface
