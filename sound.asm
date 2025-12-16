
sound:
	fdb start@
	fcz "SOUND TEST"
start@:
	lbsr cls
	ldx #playing@
	ldy #screen+7*32+5
	lbsr print_string
	lbsr go_slow
	lda PIA_A+1
	anda #%11110111
	sta PIA_A+1
	lda PIA_A+3
	anda #%11110111
	sta PIA_A+3
	lda PIA_B+3
	ora #%00001000
	sta PIA_B+3
	ldx #notes@
main@:
	ldu ,x++
	cmpu #$0000
	beq exit@
note@:
	ldy ,x			; 6
	lda #$3f		; 3
	sta PIA_B		; 5
	lbsr delay		; 16+8y
	nop			; 2
	nop			; 2
	nop			; 2
	nop			; 2
	nop			; 2
	nop			; 2
	brn note@		; 3
	ldy ,x			; 6
	lda #$00		; 3
	sta PIA_B		; 5
	lbsr delay		; 16+8y
	leau -1,u		; 5
	cmpu #$0000		; 7
	bne note@		; 3
	leax 2,x
	bra main@
exit@:
	lda PIA_B+3
	anda #%11110111
	sta PIA_B+3
	ldx #done@
	ldy #screen+32*8+14
	lbsr print_string
	lbsr anykey
	lbra go_fast
notes@:	
	fdb 65,469	; 261.63
	fdb 73,417	; 293.66
	fdb 82,371	; 329.63
	fdb 87,350	; 349.23
	fdb 98,311	; 392.0
	fdb 110,277	; 440.0
	fdb 123,246	; 493.88
	fdb 131,232	; 523.25
	fdb 123,246	; 493.88
	fdb 110,277	; 440.0
	fdb 98,311	; 392.0
	fdb 87,350	; 349.23
	fdb 82,371	; 329.63
	fdb 73,417	; 293.66
	fdb 65,469	; 261.63
	fdb 0,0
playing@:
	fcz "PLAYING C MAJOR SCALE"
done@:
	fcz "DONE"

	
