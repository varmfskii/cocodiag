
sound:
	fdb start@
	fcz "SOUND TEST"
start@:
	lda hwflag
	sta SLOW
	bita #h6309_f
	beq c0@
	ldmd #0
c0@:
	lda hwflag
	bita #coco3_f
	beq coco12@
	sta FAST
coco12@
	bita #h6309_f
	beq exit@
	ldmd #1
exit@:
	rts

