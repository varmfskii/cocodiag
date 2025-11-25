
print_test:
	lbsr cls
	ldx #printing
	ldy #$024c
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
	lbsr anykey
	rts
	
