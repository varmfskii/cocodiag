	include ecb.inc
	include coco.inc
	include coco3.inc
toram	macro
	clr $200
	lbsr ramcpy
	fcb $16,$80,$00
	inc $200
	sta RAMRAM
	endm

torom	macro
	sta RAMROM
	fcb $16,$80,$00
	clr $200
	com $200
	endm

scr_space	equ space+$40
;;; locations
ramsize		equ $94
hwflag		equ $93
memerr		equ $92
TEMP		equ $90
;;; hardware flags
coco3_f		equ $01
mmu_f		equ $02
h6309_f		equ $04
dragon_f	equ $08
pal_f		equ $10
inram_f		equ $80
;;; memory sizes
_4k		equ $00
_16k		equ $01
_32k		equ $02
_64k		equ $03
_128k		equ $04
_256k		equ $05
_512k		equ $06
_1m		equ $07
_2m		equ $08
