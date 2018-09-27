; the mandatory null descriptor
; the GDT starts with a null 8-byte
gdt_start:
  ; 'dd' means define double word (i.e. 4 bytes)
  dd 0x0
  dd 0x0

; the code segment descriptor
gdt_code:
  ; base =0 x0 , limit =0 xfffff ,
  ; 1 st flags : ( present )1 ( privilege )00 ( descriptor type )1 -> 1001 b
  ; type flags : ( code )1 ( conforming )0 ( readable )1 ( accessed )0 -> 1010 b
  ; 2 nd flags : ( granularity )1 (32 - bit default )1 (64 - bit seg )0 ( AVL )0 -> 1100 b
  ; segment length, bits 0-15
  dw 0xffff
  ; segment base, bits 0-15
  dw 0x0
  ; segment base, bits 16-23
  db 0x0
  ; type flags, 8 bits
  db 10011010b
  ; flags, 4 bits + segment length, bits 16-19
  db 11001111b
  ; segment base, bits 24-31
  db 0x0

; the data segment descriptor
; Same as code segment except for the type flags
gdt_data:
  dw 0xffff
  dw 0x0
  db 0x0
  db 10010010b ; changed
  db 11001111b
  db 0x0

gdt_end :
; The reason for putting a label at the end of the
; GDT is so we can have the assembler calculate
; the size of the GDT for the GDT decriptor ( below )

; GDT descriptior
gdt_descriptor:
  ; Size of our GDT, always less one of the true size
  dw gdt_end - gdt_start - 1
  ; Start address of our GDT
  dd gdt_start

; Define some handy constants for the GDT segment descriptor offsets, which
; are what segment registers must contain when in protected mode. For example,
; when we set DS = 0x10 in PM, the CPU knows that we mean it to use the
; segment described at offset 0x10 (i.e. 16 bytes) in our GDT, which in our
; case is the DATA segment (0x0 -> NULL ; 0x08 -> CODE ; 0x10 -> DATA)
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
