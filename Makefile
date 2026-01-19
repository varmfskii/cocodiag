SYS=asm_inc/ecb.inc asm_inc/coco.inc asm_inc/coco3.inc constants.inc
INC=cassette.asm crctab.bin hardware.asm joystick.asm keyboard.asm	\
	memory.asm menu.asm printer.asm rom.asm rs232.asm sound.asm	\
	title.asm util.asm video.asm
OBJS=ziadiag.ccc

all: ${OBJS}

ziadiag.ccc: ziadiag.asm ${SYS} ${INC}
	lwasm -Iasm_inc -o$@ -fraw -lziadiag.txt $<

crctab.bin:
	./gencrctab.py 8005 $@

.PHONY: clean distclean build

clean:
	rm -f *~ *# *.txt crctab.bin

distclean: clean
	rm -f ${OBJS}

