build: main.o
	ld main.o -dynamic-linker /lib/ld-linux-x86-64.so.2 -lc -lraylib

main.o: main.asm
	fasm main.asm
