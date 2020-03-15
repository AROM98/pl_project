#por enquanto isto deve funcionar

finalx: lex.yy.c
	gcc -o finalx lex.yy.c -ll

lex.yy.c: file1.l
	flex file1.l

clean:
	rm lex.yy.c finalx *.o


