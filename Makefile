#por enquanto isto deve funcionar
IDIR=../include
ODIR=obj
LDIR=lib
OLDIR=$(ODIR)/lib

CC=gcc
CFLAGS = -ll -Wall -std=c11 -g -v -Ofast `pkg-config  --libs glib-2.0`
LDFLAGS = -ll -Wall -std=c11 -g -v -Ofast `pkg-config  --cflags glib-2.0`

finalx: lex.yy.o main.o
	$(CC) lex.yy.o main.o  -o finalx $(CFLAGS)

lex.yy.o: lex.yy.c head.h
	$(CC) lex.yy.c -c -o lex.yy.o $(LDFLAGS)

main.o: main.c head.h
	$(CC) main.c -c -o main.o $(LDFLAGS)

lex.yy.c: base.l
	flex base.l

clean:
	rm lex.yy.c finalx *.o *.fl *.md ReadME.txt head.h.gch Makefile1 README


