%{
#include <string.h>
char* email;
char* nome;

%}
%x meta tree makefile filemd filelex
%%
    BEGIN 0;
=== ;
meta {printf("entrei no estado meta\n"); BEGIN meta;}
tree {printf("entrei no estado tree\n"); BEGIN tree;}

<meta>=== {printf("vou sair de meta e voltar ao inicio\n"); BEGIN 0;}
<meta>email:\ ([a-z0-9]+\.)*[a-z0-9]+@([a-z0-9]+\.)+[a-z]+ {email =  yytext+7; 
                                                            printf("seu email é: %s\n", email);}
<meta>author:\ ([a-zA-Z|ç|ã|á|à|â|é]+(\.|\ )*)+ {nome = yytext+8;
                                            printf("o autor é: %s\n", nome);}
<meta>.|\n ;


<tree>=== {printf("vou sair de tree e voltar ao inicio\n"); BEGIN 0;}
<tree>.|\n ;

<makefile>=== {printf("vou sair de tree e voltar ao inicio\n"); BEGIN 0;}
<makefile>.|\n ;

<filemd>=== {printf("vou sair de tree e voltar ao inicio\n"); BEGIN 0;}
<filemd>.|\n ;

<filelex>=== {printf("vou sair de tree e voltar ao inicio\n"); BEGIN 0;}
<filelex>.|\n ;


%%





