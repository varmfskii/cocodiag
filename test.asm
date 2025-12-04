	include coco3.inc
COL equ $fd
FG equ $fe
BG equ $ff
	org $c000
	lda #$03		;
	sta INIT0
	lda VMODE
	anda #$78
	ora #$03
	ldb #$75
	std VMODE		; and VRES
	ldd #$e080
	std VOFF
	ldx #palette
	ldy #PAL
setpal:
	lda ,x+
	sta ,y+
	cmpx #fill
	bne setpal
	ldx #$0400
	lda #$20
	ldb #80
	stb COL
	clr FG
	clr BG
l3:
	sta ,x+
	ldb FG
	orb BG
	stb ,x+
	inca
	addb #$08
	andb #$38
	stb FG
	dec COL
	bne s
	ldb #80
	stb COL
	ldb BG
	incb
	andb #$07
	stb BG
s:	
	cmpx #$2000
	bne l3
endlp:
	bra endlp
palette:
	fcb $00,$08,$10,$18,$20,$28,$30,$38
	fcb $07,$09,$12,$1b,$24,$2d,$36,$3f
fill:
	rmb $c800-fill
	end
