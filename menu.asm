;;; main menu

menu:
	lbsr cls
	lda #'-'|$40
	ldy #screen+4*32+1
hline@:
	sta ,y+
	cmpy #screen+4*32+17
	bne hline@
	ldx #title
	ldy #screen+0*32+9
	lbsr print_string
	ldy #screen+1*32+8
	lbsr print_string
	ldy #screen+3*32+12
	ldx #menu_title
	lbsr print_string
	ldy #screen+5*32+1
	ldu #entries
	lda #'A'|$40
	sta TEMP
menu@:
	ldx ,u
	beq poll@
	lda TEMP
	sta ,y+
	inca
	sta TEMP
	ldd #(')'*256+' ')|$4040
	std ,y++
	leax 2,x
	lbsr print_string
	leau 2,u
	tfr y,d
	andb #$e0
	addd #$21
	tfr d,y
	bra menu@
poll@:
	jsr [POLCAT]
	beq poll@
	cmpa #'J'
	bgt poll@
	suba #'A'
	blt poll@
	lsla
	ldx #entries
	ldx a,x
	jsr [,x]
	bra menu
	
entries:
	fdb showhw,memtest,romtest,video
	fdb keyboard,joystick,sound,cassette
	fdb rs232,print
	fdb 0

test:
	clra
	ldy #screen
loop@:
	sta ,y+
	inca
	bne loop@
	lbra anykey

menu_title:
	fcz "MAIN MENU"
