TEMP equ $0500
scr_space equ 96
	org $c000
	ldx #$0400
	ldd #96*256+96
loop@:
	std ,x++
	cmpx #$0600
	bne loop@
	ldx #$8000
	ldy #$a000
	ldd #$0000
	std TEMP
	lbsr crc16
	ldy #$0400
	lda TEMP
	lbsr print_hex
	lda TEMP+1
	lbsr print_hex
	ldx #$a000
	ldy #$c000
	ldd #$0000
	std TEMP
	lbsr crc16
	ldy #$0420
	lda TEMP
	lbsr print_hex
	lda TEMP+1
	lbsr print_hex
	ldx #$8000
	ldy #$c000
	ldd #$0000
	std TEMP
	lbsr crc16
	ldy #$0440
	lda TEMP
	lbsr print_hex
	lda TEMP+1
	lbsr print_hex
endlp:
	bra endlp

	include "rom.asm"
	include "print.asm"
fill:
	rmb $e000-fill
	end
	
