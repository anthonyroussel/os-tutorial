[bits 32]
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null - terminated string pointed to by EDX
print_pm:
  pusha
  ; Set edx to the start of vid mem
  mov edx, VIDEO_MEMORY

print_pm_loop:
  mov al, [ebx]

  ; Store the char at EBX in AL
  mov ah, WHITE_ON_BLACK ; Store the attributes in AH
  cmp al, 0

  ; jump to done
  je print_pm_done ; if ( al == 0) , at end of string , so

  ; Store char and attributes at current character cell.
  mov [edx], ax ;

  ; Increment EBX to the next char in string.
  add ebx, 1

  ; Move to next character cell in vid mem.
  add edx, 2

  ; loop around to print the next char.
  jmp print_pm_loop

print_pm_done:
  popa
  ret
