
print:
	fdb start@
	fcz "PRINTER TEST"
start@:
	sta SLOW
	lda hwflag
	bita #h6309_f
	beq c0@
	ldmd #0
c0@:
	lbsr cls
	ldx #printing
	ldy #$024c
	lbsr print_string
	lda #-1
	sta DEVNUM
	lda cr
	jmp [CHROUT]
	lda $20
loop@:
	jmp [CHROUT]
	inca
	cmpa #$7e
	ble loop@
	lda cr
	jmp [CHROUT]
	clr DEVNUM
	ldx #done
	ldy #$024e
	lbsr print_string
	lbsr anykey
	lda hwflag
	bita #coco3_f
	beq coco12@
	sta FAST
coco12@:
	bita #h6309_f
	beq exit@
	ldmd #1
exit@:
	rts

printing:
	fcz "PRINTING"
done:
	fcz "DONE"

