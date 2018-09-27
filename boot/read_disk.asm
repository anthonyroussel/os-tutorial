; load DH sectors to ES : BX from drive DL
disk_load:
  push dx

  ; BIOS read sector function
  mov ah, 0x02
  ; Read dh sectors
  mov al, dh
  ; Select cylinder 0
  mov ch, 0x00
  ; Select head 0
  mov dh, 0x00
  ; Start reading from second sector (i.e. after boot sector)
  mov cl, 0x02
  ; BIOS read-disk interrupt
  int 0x13
  ; Jump if error (i.e. carry flag set)
  jc disk_error

  ; Restore dx from the stack
  pop dx
  ; If AL (sectors read) != DH (sectors) expected, display error message
  cmp dh, al
  jne disk_error
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print
  jmp $

DISK_ERROR_MSG:
  db 'Disk read error!', 0x0d, 0x0a, 0
