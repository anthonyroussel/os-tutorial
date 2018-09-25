cls:
  pusha

  ; int 10h, ah 0h: Interrupt BIOS/set video mode
  mov ah, 0x00
  ; al is the desired video mode:
  ; 00h - text mode. 40x25. 16 colors. 8 pages.
  ; 03h - text mode. 80x25. 16 colors. 8 pages.
  ; 13h - graphical mode. 40x25. 256 colors. 320x200 pixels. 1 page.
  mov al, 0x03
  int 0x10

  popa
  ret
