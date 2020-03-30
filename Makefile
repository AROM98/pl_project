#por enquanto isto deve funcionar

finalx: lex.yy.o main.o
	gcc -o finalx lex.yy.o main.o -ll

lex.yy.o: lex.yy.c head.h
	gcc -c lex.yy.c head.h

main.o: main.c head.h
	gcc -c main.c head.h

lex.yy.c: base.l
	flex base.l

clean:
	rm lex.yy.c finalx *.o *.fl *.md ReadME.txt head.h.gch Makefile1 README


