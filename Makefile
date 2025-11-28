SYS=asm_inc/ecb.asm asm_inc/coco.asm asm_inc/coco3.asm constants.asm
INC=hardware.asm memory.asm menu.asm util.asm printer.asm rom.asm \
	video.asm crctab.bin
OBJS=diag.ccc

all: ${OBJS}

diag.ccc: diag.asm ${SYS} ${INC}
	lwasm $< -o$@ -fraw -ldiag.txt

crctab.bin:
	./gencrctab.py 8005 $@

.PHONY: clean distclean build

clean:
	rm -f *~ *.txt crctab.bin

distclean: clean
	rm ${OBJS}
