

cassette:
	fdb start@
	fcz "CASSETTE TEST"
start@:
	lbsr cls
	ldy #$0222
	ldx #write_cas
	lbsr print_string
	clra
	ldx #$0300
loop@:
	sta ,x+
	inca
	bne loop@
yes@:
	jsr [POLCAT]
	bne yes@
	cmpa #'Y'
	bne yes@
	ldd #$0300
	std CBUFAD
	ldd #$02ff
	std BLKTYP
	jsr [WRTLDR]
	jsr [BLKOUT]
	lda PIA_B+1
	anda #$f7
	sta PIA_B+1
	ldx #read_cas
	ldy #$0220
	lbsr print_string
	ldd #$0300
	std CBUFAD
	jsr [CSRDON]
	jsr [BLKIN]
	lda PIA_B+1
	anda #$f7
	sta PIA_B+1
	ldd BLKTYP
	cmpd #$02ff
	bne error@
	ldx #$0300
	clra
loop2@:
	cmpa ,x+
	bne error@
	inca
	bne loop2@
	ldx #good_cas
	ldy #$0248
	lbsr print_string
	lbra anykey
error@:
	ldx #again_cas
	ldy #$0243
	lbsr print_string
loop3@:
	jsr [POLCAT]
	bne loop3@
	cmpa #'Y'
	lbeq start@
	cmpa #'N'
	bne loop3@
	rts

write_cas:
	fcz "IS CASSETTE READY TO RECORD?"
read_cas:
	fcz "REWIND CASSETTE AND PRESS A KEY"
good_cas:
	fcz "CASSETTE IS GOOD"
again_cas:
	fcz "CASSETTE ERROR. TRY AGAIN?"
	
