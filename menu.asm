;;; main menu

menu:
	lbsr cls
	lda #'-'|$40
	ldy #$0281
hline@:
	sta ,y+
	cmpy #$029f
	bne hline@
	ldx #title
	ldy #$0209
	lbsr print_string
	ldy #$0228
	lbsr print_string
	ldx #main_menu
	ldy #$026c
	lbsr print_string
	ldy #$02a1
menu@:
	lbsr print_string
	tfr y,d
	andb #$e0
	addd #$21
	tfr d,y
	lda ,x
	bne menu@
poll@:
	jsr [POLCAT]
	beq poll@
	cmpa #'E'
	bgt poll@
	suba #'A'
	blt poll@
	lsla
	sta $0220
	ldx #menu_tbl
	jsr [a,x]
	bra menu
	

menu_tbl:
	fdb showhw,memtest,print_test,romtest,video_test

test:
	clra
	ldy #$0200
loop@:
	sta ,y+
	inca
	bne loop@
	lbra anykey

main_menu:
	fcz "MAIN MENU"
	fcz "A) HARDWARE INFO"
	fcz "B) MEMORY TEST"
	fcz "C) PRINTER TEST"
	fcz "D) ROM TEST"
	fcz "E) VIDEO TEST"
	fcz "*) SOUND TEST"
	fcz "*) JOYSTICK TEST"
	fcz "*) KEYBOARD TEST"
	fcb $00

