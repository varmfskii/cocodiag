
print:
	fdb start@
	fcz "PRINTER TEST"
start@:
	lbsr go_slow
	lbsr cls
	ldx #printing
	ldy #screen+2*32+12
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
	ldy #screen+2*32+14
	lbsr print_string
	lbsr anykey
	lbra go_fast

printing:
	fcz "PRINTING"
done:
	fcz "DONE"

