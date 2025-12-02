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
	ldy #$26c
	ldx #menu_title
	lbsr print_string
	ldy #$02a1
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
	cmpa #'E'
	bgt poll@
	suba #'A'
	blt poll@
	lsla
	ldx #entries
	ldx a,x
	jsr [,x]
	bra menu
	

entries:
	fdb showhw,memtest,print_test,romtest,video_test,0

test:
	clra
	ldy #$0200
loop@:
	sta ,y+
	inca
	bne loop@
	lbra anykey

menu_title:
	fcz "MAIN MENU"
