
keyboard:
	fdb start@
	fcz "KEYBOARD TEST"
start@:
	lbsr cls
	ldx #kb_title
	ldy #$0208
	lbsr print_string
	ldx #$0284
	lda hwflag
	anda #dragon_f
	bne dragon@
	ldy #cmatrix
	bra l0@
dragon@:
	ldy #dmatrix
l0@:
	ldb #8
l1@:
	lda ,y+
	ora #$40
	sta ,x
	leax 3,x
	decb
	bne l1@
	leax 8,x
	cmpx #$0364
	blt l0@
	
main@:	
	lda #$fe
	ldx #$0284
l0@:
	ldb #$07
	stb TEMP
	sta KB_COL
	ldb KB_ROW
l1@:
	lsrb
	stb TEMP+1
	bcc skip@
	ldb ,x
	orb #$40
	bra cont@
skip@:
	ldb ,x
	andb #$bf
cont@:
	stb ,x
	ldb TEMP+1
	leax 32,x
	dec TEMP
	bne l1@
	leax -221,x
	orcc #$01
	rola
	cmpa #$ff
	bne l0@
	lda #$7f
	sta KB_COL
	lda KB_ROW
	cmpa #$bf		; shift
	bne main@
	lda #$fb
	sta KB_COL
	lda KB_ROW
	cmpa #$bf		; escape
	bne main@
	rts

kb_title:
	fcz "SHIFT+ESC TO END"
cmatrix:
	fcb '@','A','B','C','D','E','F','G'
	fcb 'H','I','J','K','L','M','N','O'
	fcb 'P','Q','R','S','T','U','V','W'
	fcb 'X','Y','Z','^','V','<','>',$ff
	fcb '0','1','2','3','4','5','6','7'
	fcb '8','9',':',';','<','-','>','/' 
	fcb 'E','C','E','A','C','1','2','S'
dmatrix:
	fcb '0','1','2','3','4','5','6','7'
	fcb '8','9',':',';','<','-','>','/' 
	fcb '@','A','B','C','D','E','F','G'
	fcb 'H','I','J','K','L','M','N','O'
	fcb 'P','Q','R','S','T','U','V','W'
	fcb 'X','Y','Z','^','V','<','>',$ff
	fcb 'E','C','E','A','C','1','2','S'

