; AND and SHR x86 assembly instructions
;
; see
; * https://www.aldeid.com/wiki/X86-assembly/Instructions/and
; * https://www.aldeid.com/wiki/X86-assembly/Instructions/shr
;
; Prints the value of DX as hex.
;
print_hex:
  ; Save the register values to the stack for later
  pusha
  ; Start the counter: we want to print 4 characters
  ; 4 bits per char, so we're printing a total of 16 bits
  mov cx, 4

char_loop:
  ; Decrement the counter
  dec cx
  ; Copy bx into ax so we can mask it for the last chars
  mov ax, dx
  ; Shift bx 4 bits to the right
  shr dx, 4
  ; Mask ah to get the last 4 bits
  and ax, 0xf

  ; Set bx to the memory address of our string
  mov bx, HEX_OUT
  ; Skip the '0x'
  add bx, 2
  ; Add the current counter to the address
  add bx, cx

  ; Check to see if it's a letter or number
  cmp ax, 0xa
  ; If it's a number,  go straight to setting the value
  jl set_letter
  add byte [bx], 7  ; If it's a letter,  add 7
                    ; Why this magic number? ASCII letters start 17
                    ; characters after decimal numbers. We need to cover that
                    ; distance. If our value is a 'letter' it's already
                    ; over 10,  so we need to add 7 more.
  jl set_letter

set_letter:
  ; Add the value of the byte to the char at bx
  add byte [bx], al
  ; Check the counter,  compare with 0
  cmp cx, 0
  ; If the counter is 0, finish
  je print_hex_done
  ; Otherwise loop again
  jmp char_loop

print_hex_done:
  ; Print the string pointed to by bx
  mov bx, HEX_OUT
  call print_string

  ; Pop the initial register values back from the stack
  popa
  ; Return the function
  ret

; global variables
HEX_OUT: db '0x0000', 0
