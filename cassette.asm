motor_off	macro
	lda $ff21
	anda #$f7
	sta $ff21
	endm


cassette:
	fdb start@
	fcz "CASSETTE TEST"
start@:
	lbsr cls
	ldy #screen+32+2
	ldx #write_cas
	lbsr print_string
	lbsr go_slow
yes@:
	jsr [POLCAT]
	beq yes@
	cmpa #'Y'
	bne yes@
	clra
	ldx #screen+8*32
loop@:
	sta ,x+
	inca
	bne loop@
	;; set default cassette parameters
	clr $84			; rise
	ldd #$1218		; threshold, upper pulse width limit
	std $8f
	ldd #$0a01		; lower pulse width limit, gap length
	std $91
	ldd #screen+8*32
	std CBUFAD
	ldd #$02ff
	std BLKTYP
	jsr [WRTLDR]
	jsr [BLKOUT]
	motor_off
	lbsr cls
	ldx #read_cas
	ldy #screen+32
	lbsr print_string
	lbsr anykey
	ldd #screen+8*32
	std CBUFAD
	jsr [CSRDON]
	jsr [BLKIN]
	motor_off
	ldd BLKTYP
	cmpd #$02ff
	bne error@
	ldx #screen+8*32
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
	lbsr anykey
	lbra go_fast
error@:
	ldx #again_cas
	ldy #screen+2*32+3
	lbsr print_string
loop3@:
	jsr [POLCAT]
	beq loop3@
	cmpa #'Y'
	lbeq start@
	cmpa #'N'
	bne loop3@
	lbra go_fast

write_cas:
	fcz "IS CASSETTE READY TO RECORD?"
read_cas:
	fcz "REWIND CASSETTE AND PRESS A KEY"
good_cas:
	fcz "CASSETTE IS GOOD"
again_cas:
	fcz "CASSETTE ERROR. TRY AGAIN?"
	
