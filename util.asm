
;;;
;;; cls
;;;
cls:
	ldy #$0200
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
	ldb VDG
	andb #$07
	orb 1,s
	stb VDG
	;; set address to $0000
	sta SAM_f0		; $0200 off
	sta SAM_f1		; $0400 off
	sta SAM_f2		; $0800 off
	sta SAM_f3		; $1000 off
	sta SAM_f4		; $2000 off
	sta SAM_f5		; $4000 off
	sta SAM_f6		; $8000 off
	lsra
	ldx #SAM_f0+1
loop@:
	cmpa #$00
	beq exit@
	lsra
	bcc skip@
	sta ,x
skip@:
	leax 2,x
	bra loop@
exit@:
	puls d,pc

	
