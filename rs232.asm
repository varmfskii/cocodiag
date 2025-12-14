
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
	lda $ff20		; 5 = 5
	ora #%00000010		; 2 = 7
	sta $ff20		; 5 = 12
	ldy #273		; 6 = 18
	lbsr delay		; 8*(y+2) = 2218
	nop			; 2 = 2220
	nop			; 2 = 2222
	nop			; 2 = 2224
	brn error@		; 3 = 2227
	ldb $ff22		; 5 = 2232
	bitb #%00000001		; 2 = 2234
	beq error@		; 3 = 2237
	;; value 0 - 2237 cycles - 4000.28 bps
	lda $ff20		; 5 = 5
	anda #%11111101		; 2 = 7
	sta $ff20		; 5 = 12
	ldy #272		; 6 = 18
	lbsr delay		; 8*(y+2) = 2210
	nop 			; 2 = 2212
	nop 			; 2 = 2214
	nop 			; 2 = 2216
	brn error@		; 3 = 2219
	ldb $ff22		; 5 = 2224
	bitb #%00000001		; 2 = 2226
	bne error@		; 3 = 2229
	leax 1,x		; 5 = 2234
	bne loop@		; 3 = 2237
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

testing_rs232:
	fcz "TESTING RS232"
rs232_bad:
	fcz "RS232 ERROR"
rs232_good:
	fcz "RS232 PASS"
