
print_test:
	fdb start@
	fcz "PRINTER TEST"
start@:
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
	lbra anykey

printing:
	fcz "PRINTING"
done:
	fcz "DONE"

