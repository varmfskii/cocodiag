	include "constants.inc"
	org $c000
start:
	orcc #$50
	ldx #$1000
	tfr x,s
	lda #$02
	lbsr settxt
	lbsr cls
	lbsr title_scn
	ldu #$0400
	ldx #$0000
	lbsr tst_page
	lda $0400
	bne page0err
	sta $0000
	ldu #$0000
	ldx #$0100
	lbsr tst_page
	lda $0001
	bne page1err
	ldx #screen
	tfr x,s
	lbsr hardware
	lbsr anykey
	lbra menu
	;; lbsr showhw
	;; clra
	;; lbsr settxt
endlp:
	inc $03e0
	bra endlp

page0err:
	ldx #page0
	ldy #screen+13*32+10
	lbsr print_string

	
blink:
	sta SLOW
	ldy #screen+13*32+10
	ldb #12
loop@:
	lda ,y
	eora #$40
	sta ,y+
	decb
	bne loop@
	ldd #$0000
delay@:
	addd #-1
	bne delay@
	bra blink
	
page1err:
	ldx #page1
	ldy #screen+13*32+10
	lbsr print_string
	bra blink
	
	include "title.asm"
	include "cassette.asm"
	include "hardware.asm"
	include "joystick.asm"
	include "keyboard.asm"
	include "menu.asm"
	include "printer.asm"
	include "rom.asm"
	include "rs232.asm"
	include "sound.asm"
	include "util.asm"
	include "video.asm"
 	include "memory.asm"

title:	fcz "COLOR COMPUTER"
	fcz "DIAGNOSTICS CART"
version:
	fcz "VERSION  1.1"
	fcz "(C) 2025 ZIA COMPUTING"
page0:	fcz "PAGE 0 ERROR"
page1:	fcz "PAGE 1 ERROR"
blank:	fcz "            "

fill:
	rmb $e000-fill
	end
