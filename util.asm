
;;;
;;; cls
;;;
cls:
	ldy #screen
	ldd #scr_space*257
loop@:
	std ,y++
	cmpy #$0400
	bne loop@
	rts
	
;;;
;;; print string
;;;
;;; x - start of string
;;; y - screen address of cursor (updated to end of string)
;;;
print_string
loop@:
	lda ,x+
	beq exit@
	ora #$40
	sta ,y+
	bra loop@
exit@:
	rts

;;; 
;;; print hex digit
;;;
;;; a - value to print
;;; y - screen address of cursor (updated to end of value)
;;;
print_hex:	
	pshs a
	lsra
	lsra
	lsra
	lsra
	bsr digit@
	lda #$0f
	anda ,s
	bsr digit@
	puls a,pc
digit@:
	cmpa #10
	bge letter@
	adda #'0'+64
	sta ,y+
	rts
letter@:
	adda #'A'-10
	sta ,y+
	rts
	
settxt:
;;;
;;; put in text mode and set gfx address to page a
;;; 
;;; a = page number
;;;
	ldb #$08 		; text mode alternate color
setgfx:
;;;
;;; set graphics mode
;;; 
;;; a = page number
;;; b = graphics mode
;;;
	pshs d
	andb #$f8
	stb TEMP
	ldb VDG
	andb #$07
	orb TEMP
	stb VDG
	ldu #SAM
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

;;;
;;; ramcpy - copy rom to ram ($c000-$e000 -> $4000-$6000)
;;;
ramcpy:
	pshs d,x,y
	lda hwflag
	anda #inram_f
	bne exit@
	ldx #$c000
	ldy #$4000
loop@:
	lda ,x+
	sta ,y+
	cmpx #$e000
	bne loop@
	lda hwflag
	ora #inram_f
	sta hwflag
exit@:
	inc $200
	puls x,y,d,pc

	
	
