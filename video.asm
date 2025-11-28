
video_test:
	ldx #$0400
	clra
loop@:
	sta ,x+
	inca
	cmpx #$1c00
	bne loop@
	lda hwflag
	anda #coco3_f
	bne coco3@
	ldy #modes
	bsr mode6847
	lda ramsize
	cmpa #_4k
	beq exit@
	bsr mode6847
exit@:
	ldd #$0208
	lbsr setgfx
	rts
coco3@:
	ldy #mode3
	bsr mode6847
	rts
	
mode6847:
	ldb ,y+
	beq exit@
	lda #$04
	lbsr setgfx
	lbsr anykey
	bra mode6847
exit@:
	rts

modes:
	fcb $08			; sg4		512
	fcb $18			; sg6		512
	fcb $0a			; sg8		2048
	fcb $0c			; sg12		3072
	fcb $89			; 64x64f	1024
	fcb $99			; 128x64t	1024
	fcb $aa			; 128x64f	2048
	fcb $bb			; 128x96t	1536
	fcb $cc			; 128x96f	3072
	fcb $dd			; 128x192t	3072
	fcb $00
	fcb $0e			; sg24		6144
	fcb $ee			; 128x192f	6144
	fcb $fe			; 256x192t	6144
	fcb $00
mode3:
	fcb $08,$89,$99,$aa,$bb,$cc,$dd,$ee,$fe,$00
