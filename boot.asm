; Read some sectors from the boot disk using our disk_read function
[org 0x7c00]
KERNEL_OFFSET equ 0x1000

  ; the BIOS sets us the boot drive in 'dl' on boot
  mov [BOOT_DRIVE], dl

  mov bp, 0x9000
  mov sp, bp

  ; Real mode
  mov bx, MSG_REAL_MODE
  call print

  ; read the kernel from disk
  call load_kernel
  ; disable interrupts, load GDT then switch to protected mode.
  call pm
  ; wait indefinitely
  jmp $

; file inclusions
; ===============
%include "functions/print.asm"
%include "functions/print_hex.asm"
%include "functions/read_disk.asm"
%include "functions/cls.asm"
%include "functions/gdt.asm"
%include "functions/print_pm.asm"
%include "functions/pm.asm"

[bits 16]
load_kernel:
  mov bx, MSG_LOAD_KERNEL
  call print

  ; Read from disk and store in 0x1000
  mov bx, KERNEL_OFFSET
  mov dh, 15
  mov dl, [BOOT_DRIVE]
  call disk_load
  ret

; protected mode
; ==============
[bits 32]
BEGIN_PM:
  mov ebx, MSG_PROTECTED_MODE
  call print_pm
  call KERNEL_OFFSET
  jmp $

; data
; ====
; db stands for "declare bytes"
; and write directly into binary output file
BOOTING_MSG:
  db 'Booting OS...', 0x0d, 0x0a, 0
MSG_REAL_MODE:
  db 'Started in 16-bit real mode', 0x0d, 0x0a, 0
MSG_PROTECTED_MODE:
  db 'Successfully landed in 32-bit protected mode', 0x0d, 0x0a, 0
MSG_LOAD_KERNEL:
  db 'Loading kernel into memory', 0x0d, 0x0a, 0
BOOT_DRIVE:
  db 0

; bios magic number
; =================
times 510-($-$$) db 0
dw 0xaa55
