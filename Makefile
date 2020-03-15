#por enquanto isto deve funcionar

finalx: lex.yy.c
	gcc -o finalx lex.yy.c -ll

lex.yy.c: base.l
	flex base.l

clean:
	rm lex.yy.c finalx


