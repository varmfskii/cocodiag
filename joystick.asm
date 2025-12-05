
joystick:
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
	std TEMP
	std TEMP+2
	ldd #$0400+_128x96f
	lbsr setgfx
joy@
	jsr [JOYIN]
	lda POTVAL+1
	ldb POTVAL
	bsr getpos
	leax $0410,x
	clr [TEMP]
	sta ,x
	stx TEMP
	lda POTVAL+3
	ldb POTVAL+2
	bsr getpos
	leax $0400,x
	clr [TEMP+2]
	sta ,x
	stx TEMP+2
	clr $0f04
	clr $0f0c
	clr $0f14
	clr $0f1c
	clr $0f24
	clr $0f2c
	clr $0f34
	clr $0f3c
	lda PIA_A
	bita #$01
	bne s0@
	com $0f14
	com $0f34
s0@:
	bita #$02
	bne s1@
	com $0f04
	com $0f24
s1@:
	bita #$04
	bne s2@
	com $0f1c
	com $0f3c
s2@:
	bita #$08
	bne s3@
	com $0f0c
	com $0f2c
s3@:
	jsr [POLCAT]
	beq joy@
	cmpa #3			; escape
	bne joy@
	ldd #screen
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
