	org $7000
delay	equ $0200
start:
	lda $ff01
	anda #%11110111
	sta $ff01
	lda $ff03
	anda #%11110111
	sta $ff03
	lda $ff23
	ora #%00001000
	sta $ff23
	ldx #table
mainlp:
	ldu ,x++
	cmpu #$0000
	beq exit
note:	
	ldy ,x
	lda #$3f
	sta $ff20
	sta $0400
hilp:
	leay -1,y
	bne hilp
	ldy ,x
	lda #$00
	sta $ff20
	sta $0400
lolp:
	leay -1,y
	bne lolp
	leau -1,u
	cmpu #$0000
	bne note
	leax 2,x
	bra mainlp
exit:
	rts
table:	fdb 31,523,34,494,37,440,42,392,47,349,50,330,56,294,62,262
	fdb 56,294,50,330,47,346,42,392,37,440,34,494,31,523,0,0
	end start
	
