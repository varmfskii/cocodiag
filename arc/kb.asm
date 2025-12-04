	org $4000
start:
	lbsr cls
	ldx #message
	ldy #$0408
	lbsr print_string
	ldx #$0484
	ldy #matrix
l0:
	ldb #8
l1:
	lda ,y+
	ora #$40
	sta ,x
	leax 3,x
	decb
	bne l1
	leax 8,x
	cmpx #$0584
	blt l0
main:	
	lda #$fe
	ldx #$0484
loop0:
	ldb #$08
	stb temp
	sta $ff02
	ldb $ff00
loop1:
	lsrb
	pshs b
	bcc skip1
	ldb ,x
	orb #$40
	bra cont1
skip1:
	ldb ,x
	andb #$bf
cont1:
	stb ,x
	puls b
	leax 32,x
	dec temp
	bne loop1
	leax -253,x
	orcc #$01
	rola
	cmpa #$ff
	bne loop0
	lda #$7f
	sta $ff02
	lda $ff00
	cmpa #$bf		; shift
	bne main
	lda #$fb
	sta $ff02
	lda $ff00
	cmpa #$bf		; escape
	bne main
	rts
temp:	rmb 1
message:
	fcz "SHIFT+ESC TO END"
cmatrix:
	fcb '@','A','B','C','D','E','F','G'
	fcb 'H','I','J','K','L','M','N','O'
	fcb 'P','Q','R','S','T','U','V','W'
	fcb 'X','Y','Z','^','V','<','>',$ff
	fcb '0','1','2','3','4','5','6','7'
	fcb '8','9',':',';','<','-','>','/' 
	fcb 'E','C','E','A','C','1','2','S'
	fcb 'J','J','J','J','J','J','J','J'
matrix:	
dmatrix:
	fcb '0','1','2','3','4','5','6','7'
	fcb '8','9',':',';','<','-','>','/' 
	fcb '@','A','B','C','D','E','F','G'
	fcb 'H','I','J','K','L','M','N','O'
	fcb 'P','Q','R','S','T','U','V','W'
	fcb 'X','Y','Z','^','V','<','>',$ff
	fcb 'E','C','E','A','C','1','2','S'
	fcb 'J','J','J','J','J','J','J','J'

cls:
	lda #96
	ldx #$0400
loop@:
	sta ,x+
	cmpx #$0600
	bne loop@
	rts

print_string:
	lda ,x+
	beq exit@
	ora #$40
	sta ,y+
	bra print_string
exit@:
	rts
	end start
	
