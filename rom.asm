
romtest:
	fdb start@
	fcz "ROM TEST"
start@:
	lbsr cls
	ldy #$20c
	ldx #romstr
	lbsr print_string
	ldy #$220
	ldd #('-'|$40)*257
loop@:
	std ,y++
	cmpy #$240
	bne loop@
	lda hwflag
	bita #dragon_f
	bne dragon@
	lbsr checkcb
	lbsr checkecb
	lbra anykey
dragon@:
	lbsr checkdb
	lbra anykey
	
checkcb:
	ldy #$0240
	ldx #colorbasic
	lbsr print_string
	pshs y
	ldd #$0000
	std TEMP
	ldx #$a000
	ldy #$c000
	lbsr crc16
	puls y
	lda TEMP
	lbsr print_hex
	lda TEMP+1
	lbsr print_hex
	ldx #cbtab
	ldd TEMP
loop@:
	cmpd ,x
	beq exit@
	leax 4,x
	cmpx #ecbtab
	bne loop@
	ldx #unk
	lbra print_string
exit@:
	ldx 2,x
	lbra print_string

checkecb:
	ldy #$0260
	ldx #excolorbasic
	lbsr print_string
	pshs y
	ldd #$0000
	std TEMP
	ldx #$8000
	ldy #$a000
	lbsr crc16
	puls y	
	lda TEMP
	lbsr print_hex
	lda TEMP+1
	lbsr print_hex
	ldx #ecbtab
	ldd TEMP
loop@:
	cmpd ,x
	beq exit@
	leax 4,x
	cmpx #secbtab
	bne loop@
	ldx #unk
	lbra print_string
exit@:
	ldx 2,x
	lbra print_string

checksecb:
checkdb:	
	ldy #$0240
	ldx #dragonbasic
	lbsr print_string
	pshs y	
	ldd #$0000
	std TEMP
	ldx #$8000
	ldy #$c000
	lbsr crc16
	puls y
	lda TEMP
	lbsr print_hex
	lda TEMP+1
	lbsr print_hex
	ldx #dbtab
	ldd TEMP
loop@:
	cmpd ,x
	beq exit@
	leax 4,x
	cmpx #romtabend
	bne loop@
	ldx #unk
	lbra print_string
exit@:
	ldx 2,x
	lbra print_string

cbtab:
	fdb $47c3,v10
	fdb $3123,v11
	fdb $400a,v12
	fdb $0c1f,v13
	fdb $6ea2,v14
ecbtab:
	fdb $3441,v10
	fdb $2d38,v11
secbtab:
dbtab:
	fdb $494c,d32
	fdb $0be1,d64
romtabend:	
crc16:
	pshs y
	ldy #crctab
loop@:
	ldb ,x+
	eorb TEMP+1
	clra
	lslb
	rola
	ldd d,y
	eorb TEMP
	std TEMP
	cmpx ,s
	bne loop@
	puls y,pc
	
rom_test:
	rts

crctab:
	includebin "crctab.bin"
	
romstr:	fcz "ROM TEST"
colorbasic:
	fcz "COLOR BASIC: "
excolorbasic:
	fcz "EXTENDED COLOR BASIC: "
dragonbasic:
	fcz "DRAGON BASIC: "
unk:	fcz " UNK"
v10:	fcz " 1.0"
v11:	fcz " 1.1"
v12:	fcz " 1.2"
v13:	fcz " 1.3"
v14:	fcz " 1.4"
d32:	fcz " 1.0 32K"
d64:	fcz " 1.0 64K"
