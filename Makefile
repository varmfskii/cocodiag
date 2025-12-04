SYS=asm_inc/ecb.inc asm_inc/coco.inc asm_inc/coco3.inc constants.inc
INC=cassette.asm crctab.bin hardware.asm joystick.asm keyboard.asm	\
	memory.asm menu.asm printer.asm rom.asm rs232.asm sound.asm	\
	util.asm video.asm
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

