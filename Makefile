SYS=asm_inc/ecb.inc asm_inc/coco.inc asm_inc/coco3.inc constants.inc
INC=hardware.asm memory.asm menu.asm util.asm printer.asm rom.asm \
	video.asm crctab.bin joystick.asm keyboard.asm
OBJS=diag.ccc

all: ${OBJS}

diag.ccc: diag.asm ${SYS} ${INC}
	lwasm -Iasm_inc -o$@ -fraw -ldiag.txt $<

crctab.bin:
	./gencrctab.py 8005 $@

.PHONY: clean distclean build

clean:
	rm -f *~ *.txt crctab.bin

distclean: clean
	rm ${OBJS}
