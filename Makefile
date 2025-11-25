SYS=asm_inc/coco.asm asm_inc/coco3.asm constants.asm
INC=hardware.asm memory.asm menu.asm print.asm printer.asm video.asm
OBJS=diag.ccc

all: ${OBJS}

diag.ccc: diag.asm ${SYS} ${INC}
	lwasm $< -o$@ -fraw -ldiag.txt

.PHONY: clean distclean build

clean:
	rm -f *~ *.txt

distclean: clean
	rm ${OBJS}
