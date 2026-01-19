
title:	
	lda #'*'
	ldy #screen
loop@:
	sta $01e0,y
	sta ,y+
	cmpy #$0220
	bne loop@

	ldy #screen+1*32
loop@:
	sta ,y
	sta $1f,y
	leay $20,y
	cmpy #screen+15*32
	bne loop@

	ldx #title
	ldy #screen+5*32+9
	lbsr print_string
	ldy #screen+6*32+8
	lbsr print_string
	ldx #version
	ldy #screen+12*32+10
	lbsr print_string
	ldy #screen+13*32+5
	lbra print_string

