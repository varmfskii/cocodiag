

joystick_test:
	fdb start@
	fcz "JOYSTICK TEST"
start@:
	clra
	clrb
	ldx #$0400
loop@:
	std ,x++
	cmpx #$1000
	bne loop@
	std $0150
	std $0152
	ldd #$04cc
	lbsr setgfx
joy@
	jsr [JOYIN]
	lda POTVAL+1
	ldb POTVAL
	bsr getpos
	leax $0410,x
	clr [$0150]
	sta ,x
	stx $0150
	lda POTVAL+3
	ldb POTVAL+2
	bsr getpos
	leax $0400,x
	clr [$0152]
	sta ,x
	stx $0152
	jsr [POLCAT]
	beq joy@
	ldd #$0200
	lbra setgfx
	
getpos:
	pshs b
	lslb
	lsra
	rorb
	lsra
	rorb
	lsra
	rorb
	tfr d,x
	puls b
	lda #$80
	andb #$03
bit@:
	beq exit@
	lsra
	lsra
	decb
	bra bit@
exit@:
	rts
