
video_test:
	fdb start@
	fcz "VIDEO TEST"
start@:
	lda hwflag
	anda #coco3_f
	bne coco3_menu
m6847:	
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

coco3_menu:
	ldx #PAL
	ldy #palette
pal@:
	lda ,y+
	sta ,x+
	cmpy #palend
	bne pal@
	clra
	ldy #$0600
set@:
	sta ,y+
	inca
	cmpy #$8000
	bne set@
cc3@:
	lbsr set40
	lbsr cls40
	ldd #257*'-'
	ldy #$200+40
loop@:
	std ,y++
	cmpy #$200+80
	bne loop@
	ldx #cc3_title
	ldy #$0200+12
	lbsr print3
	ldy #$0200+41
	pshs y
menu@:
	ldy ,s
	leay 40,y
	sty ,s
	lbsr print3
	lda ,x
	bne menu@
	puls y
	lda vmode
	ldy #$0200+6*40+15
	lbsr hex3
	;; bp
	lda vmode
	anda #%10000000
	rola
	rola
	rola
	ldx #bp_modes
	ldy #$0200+7*40+15
	leax [a,x]
	lbsr print3
	;; un0
	lda vmode
	anda #%01000000
	rola
	rola
	rola
	rola
	ldx #un_modes
	ldy #$0200+8*40+15
	leax [a,x]
	lbsr print3
	;; bpi
	lda vmode
	anda #%00100000
	lsra
	lsra
	lsra
	lsra
	ldx #bpi_modes
	ldy #$0200+9*40+15
	leax [a,x]
	lbsr print3
	;; moch
	lda vmode
	anda #%00010000
	lsra
	lsra
	lsra
	ldx #moch_modes
	ldy #$0200+10*40+15
	leax [a,x]
	lbsr print3
	;; h50
	lda vmode
	anda #%00001000
	lsra
	lsra
	ldx #h50_modes
	ldy #$0200+11*40+15
	leax [a,x]
	lbsr print3
	;; lpr
	lda vmode
	anda #%00000111
	lsla
	ldx #lpr_modes
	ldy #$0200+12*40+15
	leax [a,x]
	lbsr print3
	lda vres
	ldy #$0200+14*40+15
	lbsr hex3
	;; un1
	lda vres
	anda #%10000000
	rola
	rola
	rola
	ldx #un_modes
	ldy #$200+15*40+15
	leax [a,x]
	lbsr print3
	;; lpf
	lda vres
	anda #%01100000
	lsra
	lsra
	lsra
	lsra
	ldx #lpf_modes
	ldy #$0200+16*40+15
	leax [a,x]
	lbsr print3
	lda vmode
	bmi gimeg
	;; hres
	lda vres
	anda #%00011100
	lsra
	ldx #hres_tmodes
	ldy #$0200+17*40+15
	leax [a,x]
	lbsr print3
	;; cres
	lda vres
	anda #%00000011
	lsla
	ldx #cres_tmodes
	ldy #$0200+18*40+15
	leax [a,x]
	lbsr print3
	bra border
gimeg:	
	;; hres
	lda vres
	anda #%00011100
	lsra
	ldx #hres_gmodes
	ldy #$0200+17*40+15
	leax [a,x]
	lbsr print3
	;; cres
	lda vres
	anda #%00000011
	lsla
	ldx #cres_gmodes
	ldy #$0200+18*40+15
	leax [a,x]
	lbsr print3
border:
	lda brdr
	ldy #$0200+20*40+15
	lbsr hex3
poll@:
	jsr [POLCAT]
	beq poll@
	cmpa #'A'
	blt poll@
	bne s0@
	lbsr restore_gime
	lbsr m6847
	lbra cc3@
s0@:
	cmpa #'X'
	beq exit@
	cmpa #'M'
	bgt poll@
	suba #'B'
	lsla
	ldx #table@
	jmp [a,x]
exit@:
	lbra restore_gime
table@: fdb test@
	fdb bp@,un0@,bpi@,moch@,h50@,lpr@
	fdb un1@,lpf@,hres@,cres@,brdr@
test@:
	lda vmode
	sta VMODE
	lda vres
	sta VRES
	ldd #($38*$2000+$0600)/8
	std VOFF	
	lbsr anykey
	lbra cc3@
bp@:
	lda #%10000000
onebit@:
	eora vmode
	sta vmode
	lbra cc3@
un0@:
	lda #%01000000
	bra onebit@
bpi@:
	lda #%00100000
	bra onebit@
moch@:
	lda #%00010000
	bra onebit@
h50@:
	lda #%00001000
	bra onebit@
lpr@:
	lda vmode
	tfr a,b
	inca
	anda #%00000111
	andb #%11111000
	sta vmode
	orb vmode
	stb vmode
	lbra cc3@
un1@:
	lda #%10000000
	eora vres
	sta vres
	lbra cc3@
lpf@:	
	lda vres
	tfr a,b
	adda #%00100000
	anda #%01100000
	andb #%10011111
	sta vres
	orb vres
	stb vres
	lbra cc3@
hres@:
	lda vres
	tfr a,b
	adda #%00000100
	anda #%00011100
	andb #%11100011
	sta vres
	orb vres
	stb vres
	lbra cc3@
cres@:
	lda vres
	tfr a,b
	inca
	anda #%00000011
	andb #%11111100
	sta vres
	orb vres
	stb vres
	lbra cc3@
brdr@:
	lda brdr
	inca
	sta brdr
	lbra cc3@
	
restore_gime:
	lda #$80
	sta INIT0
	ldd #$0208
	lbra setgfx

set40:
	clr INIT0
	lda hwflag
	anda #pal_f
	bne pal@
	lda #%00000011
	bra c@
pal@:
	lda #%00001011
c@:
	sta VMODE
	lda #%00100100
	sta VRES
	ldd #($38*$2000+$0200)/8
	std VOFF
	lda #$12
	sta PAL
	lda brdr
	sta BRDR
	clr PAL+1
	rts

cls40:
	ldd #' '*257
	ldy #$0200
loop@:
	std ,y++
	cmpy #$200+40*25
	bne loop@
	rts
	
init0:	equ $af
vmode:	equ $ae
vres:	equ $ad
brdr:	equ $ac

print3:
	lda ,x+
	beq exit@
	sta ,y+
	bra print3
exit@:
	rts

hex3:
	pshs a
	lsra
	lsra
	lsra
	lsra
	bsr digit@
	puls a
	anda #$0f
digit@:
	cmpa #10
	bge letter@
	adda #'0'
	sta ,y+
	rts
letter@:
	adda #'A'-10
	sta ,y+
	rts
	
gmodes:
	
cc3_title:
	fcz "CoCo3 Video Menu"
	fcz "A) mc6847 test"
	fcz "B) Test GIME mode"
	fcz "X) Exit menu"
	fcz " "
	fcz "   VMODE:"
	fcz "C) BP:"
	fcz "D) UN0:"
	fcz "E) BPI:"
	fcz "F) MOCH:"
	fcz "G) H50:"
	fcz "H) LPR:"
	fcz " "
	fcz "   VRES:"
	fcz "I) UN1:"
	fcz "J) LPF:"
	fcz "K) HRES:"
	fcz "L) CRES:"
	fcz " "
	fcz "M) BRDR:" 
	fdb 0

un_modes:
	fdb _0@,_1@
_0@:	fcz "0"
_1@:	fcz "1"
	
bp_modes:
	fdb text@,graphics@
text@:
	fcz "0 Text mode"
graphics@:
	fcz "1 Graphics mode"

bpi_modes:
	fdb noinvert@,invert@
noinvert@:
	fcz "0 No phase invert"
invert@:
	fcz "1 Phase invert"

moch_modes:
	fdb color@,mono@
color@: fcz "0 Color"
mono@:	fcz "1 Monochrome"	

h50_modes:	
	fdb _60@,_50@
_60@:	fcz "0 60Hz"
_50@:	fcz "1 50Hz"

lpr_modes:
	fdb _1@,b1@,_2@,_8@,_9@,_10@,_11@,inf@
_1@:	fcz "0 1 line/row"
b1@:	fcz "1 1 line/row"
_2@:	fcz "2 2 lines/row"
_8@:	fcz "3 8 lines/row"
_9@:	fcz "4 9 lines/row"
_10@:	fcz "5 10 lines/row"
_11@:	fcz "6 11 lines/row"
inf@:	fcz "7 Infinite lines/row"

lpf_modes:
	fdb _192@,_200@,_0@,_225@
_192@:	fcz "0 192 lines/field"
_200@:	fcz "1 200 lines/field"
_0@:	fcz "2 0/infinite lines/field"
_225@:	fcz "3 192 lines/field"

hres_gmodes:
	fdb _16@,_20@,_32@,_40@,_64@,_80@,_128@,_160@
_16@:	fcz "0 16 bytes/row"
_20@:	fcz "1 20 bytes/row"
_32@:	fcz "2 32 bytes/row"
_40@:	fcz "3 40 bytes/row"
_64@:	fcz "4 64 bytes/row"
_80@:	fcz "5 80 bytes/row"
_128@:	fcz "6 128 bytes/row"
_160@:	fcz "7 160 bytes/row"

hres_tmodes:
	fdb a32@,a40@,b32@,b40@,a64@,a80@,b64@,b80@
a32@:	fcz "0 32 characters/row"
a40@:	fcz "1 40 characters/row"
b32@:	fcz "2 32 characters/row"
b40@:	fcz "3 40 characters/row"
a64@:	fcz "4 64 characters/row"
a80@:	fcz "5 80 characters/row"
b64@:	fcz "6 64 characters/row"
b80@:	fcz "7 80 characters/row"
	
cres_gmodes:
	fdb _2@,_4@,_16@,undef@
_2@:	fcz "0 2 colors"
_4@:	fcz "1 4 colors"
_16@:	fcz "2 16 colors"
undef@:
	fcz "3 undefined"

cres_tmodes:
	fdb noa@,cola@,nob@,colb@
noa@:	fcz "0 No color attrs"
cola@:	fcz "1 Color attrs"
nob@:	fcz "2 No color attrs"
colb@:	fcz "3 Color attrs"
	
palette:
	fdb %000000,%001000,%010000,%011000,%100000,%101000,%110000,%111000
	fdb %000111,%001001,%010010,%011011,%100100,%101101,%110110,%111111
palend:

	
