
rs232:
	fdb start@
	fcz "RS232 TEST"
start@:
	lbsr cls
	ldx #testing_rs232
	ldy #screen+32*7+9
	lbsr print_string
	lbsr go_slow
	ldx #$0000
loop@:
	;; value 1 - 2237 cycles - 4000.28 bps
	lda $ff20		; 5
	ora #%00000010		; 2
	sta $ff20		; 5
	bsr rs232_wait		; 7
	ldb $ff22		; 5
	bitb #%00000001		; 2
	beq error@		; 3
	nop			; 2
	nop			; 2
	nop			; 2
	nop			; 2
	;; value 0 - 2237 cycles
	lda $ff20		; 3
	anda #%11111101		; 2
	sta $ff20		; 3
	bsr rs232_wait		; 7
	ldb $ff22		; 3
	bitb #%00000001		; 2
	bne error@		; 3
	leax 1,x		; 5
	bne loop@		; 3
	lbsr cls
	ldx #rs232_good
	ldy #screen+32*7+11
	bra exit@
error@:
	lbsr cls
	ldx #rs232_bad
	ldy #screen+32*7+10
exit@:
	lbsr print_string
	lbsr anykey
	lbra go_fast

count@:	equ 273
rs232_wait:			; 14+273*22 - 2200 cycles
	ldy #count@		; 4
delay@:
	leay -1,y		; 5
	bne delay@		; 3
	nop			; 2
	nop			; 2
	brn next@		; 3
next@:
	rts			; 5

testing_rs232:
	fcz "TESTING RS232"
rs232_bad:
	fcz "RS232 ERROR"
rs232_good:
	fcz "RS232 PASS"
