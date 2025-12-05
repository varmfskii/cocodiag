

cassette:
	fdb start@
	fcz "CASSETTE TEST"
start@:
	lbsr cls
	ldy #screen+32+2
	ldx #write_cas
	lbsr print_string
yes@:
	jsr [POLCAT]
	beq yes@
	cmpa #'Y'
	bne yes@
	clra
	ldx #screen+16*32
loop@:
	sta ,x+
	inca
	bne loop@
	ldd #screen+16*32
	std CBUFAD
	ldd #$02ff
	std BLKTYP
	jsr [WRTLDR]
	jsr [BLKOUT]
	lda $ff21
	anda #$f7
	sta $ff21
	lbsr cls
	ldx #read_cas
	ldy #screen+32
	lbsr print_string
	ldd #screen+16*32
	std CBUFAD
	jsr [CSRDON]
	jsr [BLKIN]
	lda $ff21
	anda #$f7
	sta $ff21
	ldd BLKTYP
	cmpd #$02ff
	bne error@
	ldx #screen+16*32
	clra
loop2@:
	cmpa ,x+
	bne error@
	inca
	cmpa #$ff
	bne loop2@
	ldx #good_cas
	ldy #screen+2*32+8
	lbsr print_string
	lbra anykey
error@:
	ldx #again_cas
	ldy #screen+2*32+3
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
	
