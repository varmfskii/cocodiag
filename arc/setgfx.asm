	include constants.inc
setgfx:
	pshs d
	andb #$f8
	stb TEMP
	ldb VDG
	andb #$07
	orb TEMP
	stb VDG
	ldu #$ffc0
	lda 1,s
	ldb #3
	bsr dobits
	lda ,s
	lsra
	ldb #7
	bsr dobits
	puls d,pc

dobits:
	stb TEMP
loop@:
	clrb
	lsra
	adcb #$00
	stb b,u
	leau 2,u
	dec TEMP
	bne loop@
	rts
