vmode_f:	equ $ff
bp_f:	equ $80
bpi_f:	equ $20
moch_f:	equ $10
h50_f:	equ $08
lpr:	equ $fe
lpf:	equ $fd
hres:	equ $fc
cres:	equ $fb
brdr:	equ $fa
init0:	equ $f9
vmode:	equ $f8
mmu_f:	equ $40
coco_f:	equ $80

save 	macro
	lda INIT0
	sta init0
	lda VMODE
	sta vmode
	endm

restore macro
	lda init0
	sta INIT0
	lda vmode
	sta VMODE
	end
	
setgime:
	lda vmode_f
	ora lpr
	sta VMODE
	lda lpf
	ora hres
	ora cres
	sta VRES
	lda brdr
	sta BRDR
	ldd $c000		; bank $30-$35
	std VOFF
	lda INIT0
	anda #~coco_f
	sta INIT0
	rts

setvdg:
	lda INIT0
	ora #coco_f
	sta INIT0
	rts

init:
	save
	lda INIT0
	ora #mmu_f
	sta INIT0
	lda #$30
	clrb
l1@:
	sta MMU02
	ldx #$2000
l2@:	
	stb ,x+
	incb
	cmpx #$4000
	bne l2@
	inca
	cmpa #$36
	bne l1@:
	lda INIT0
	anda #~mmu_f
	sta INIT0
	lda vmode
	anda #$b8
	sta vmode_f
	lda vmode
	anda #$07
	sta lpr
	lda VRES
	anda #$60
	sta lpf
	lda VRES
	anda #$1c
	sta hres
	lda VRES
	anda #$03
	sta cres
	rts

showstate:
	ldy #$200
	ldx #t_g
	lbsr print_string
	lda vmode_f
	bita #bp
	bne skip@
	ldx #graphics
	bra cont@
skip@:
	ldx #text
cont@:
	lbsr print_string

	ldy #$220
	ldx #phase
	lbsr print_string
	lda vmode_f
	bita #bpi
	bne skip@
	ldx #invert
	bra cont@
skip@:
	ldx #normal
cont@:
	lbsr print_string

	ldy #$240
	ldx #mono
	lbsr print_string
	lda vmode_f
	bita #moch
	bne skip@
	ldx #set
	bra cont@
skip@:
	ldx #clear
cont@:
	lbsr print_string

	ldy #$260
	ldx #vsync
	lbsr print_string
	lda vmode_f
	bita #h50
	bne skip@
	ldx #_50hz
	bra cont@
skip@:
	ldx #_60hz
cont@:
	lbsr print_string

	ldy #$280
	ldx #$per_row
	lbsr print_string
	lda lpr
	lsla
	ldx #lprs
	ldx a,x
	lbsr print_string
	
	ldy #$2a0
	ldx #per_field
	lbsr print_string
	lda lpf
	lsra
	lsra
	lsra
	lsra
	ldx #lpfs
	ldx a,x
	lbsr print_string

	lda #vmode_f
	bita #bp
	bne isgraphics
istext:
	ldy #$2c0
	ldx #chars
	lbsr print_string
	lda hres
	lsra
	ldx #hresc
	ldx a,x
	lbsr print_string
	ldy #$2e0
	ldx #hasattr
	lda cres
	lsla
	ldx #cresc
	ldx a,x
	lbsr print_string
	rts
isgraphics:	
	rts
	
	
lprs:	fdb _1,_1,_2,_8,_9,_10,_11,inf
lpfs:	fdb _192,_200,inf,_225
hresb:	fdb _16b,_20b,_32b,_40b,_64b,_80b,128b,160b
hresc:	fdb _32c,_40c,_32c,_40c,_64c,_80c,_64c,_80c
cresc:	fdb _2co,_4co,_16co,undef
cresa:	fdb noatr,atr,noatr,atr
_1:	fcz "1"
_2:	fcz "2"
_8:	fcz "8"
_9:	fcz "9"
_10:	fcz "10"
_11:	fcz "11"
inf:	fcz "INFINITE"
_192:	fcz "192"
_200:	fcz "200"
_225:	fcz "225"
_16b:	fcz "16 BYTES"
_20b:	fcz "20 BYTES"
_32b:	fcz "32 BYTES"
_40b:	fcz "40 BYTES"
_64b:	fcz "64 BYTES"
_80b:	fcz "80 BYTES"
_128b:	fcz "128 BYTES"
_160b:	fcz "160 BYTES"
_32c:	fcz "32 CHARACTERS"
_40c:	fcz "40 CHARACTERS"
_64c:	fcz "64 CHARACTERS"
_80c:	fcz "80 CHARACTERS"
_2co:	fcz "2 COLORS"
_4co:	fcz "4 COLORS"
_16co:	fcz "16 COLORS"
undef:	fcz "UNDEFINED"
	
	
	
