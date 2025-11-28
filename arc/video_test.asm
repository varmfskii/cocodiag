	org $c000
start:
	ldx #$0400
	lda #$1b
	ldb #$10
loop:
	sta ,x+
	decb
	bne skip
	ldb #$10
	coma
skip:	
	cmpx #$0f00
	bne loop
	ldd #$0489
	lbsr setgfx
endlp:
	bra endlp
	ldx #$0400
	lda ,x
	sta $90
loop2:
	lda 1,x
	sta ,x+
	cmpx #$03ff
	bne loop2
	lda $90
	sta $0400
	bra endlp
	include setgfx.asm
	end
