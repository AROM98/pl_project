# pl_project


1 Objectivos e Organização
Este trabalho prático tem como principais objectivos:
• aumentar a experiência de uso do ambiente Linux e de algumas ferramentas de apoio à programação;
• aumentar a capacidade de escrever Expressões Regulares (ER) para descrição de padrões de frases;
• desenvolver, a partir de ERs, sistemática e automaticamente Processadores de Linguagens Regulares, que 􏰂ltrem ou transformem textos com base no conceito de regras de produção Condição-Ação;
• utilizar o Flex para gerar 􏰂ltros de texto em C.
Neste TP que se pretende que seja resolvido rapidamente (2 semana). Aprecia-se a imaginação/criatividade dos grupos
ao incluir outros processamentos!
Deve entregar a sua solução até Domingo dia 22 de Março. O 􏰂cheiro com o relatório e a solução deve ter o nome 'pl19TP1GrNN' 􏰁 em breve serão dadas indicações precisas sobre a forma de submissão.
O programa desenvolvido será apresentado aos membros da equipa docente, totalmente pronto e a funcionar (acom- panhado do respectivo relatório de desenvolvimento) e será defendido por todos os elementos do grupo, em data a marcar.
O relatório a elaborar, deve ser claro e, além do respectivo enunciado, da descrição do problema, das decisões que lideraram o desenho da solução e sua implementação (incluir a especi􏰂cação FLex), deverá conter exemplos de utilização (textos fontes diversos e respectivo resultado produzido). Como é de tradição, o relatório será escrito em LATEX.


2 Enunciados
Para sistematizar o trabalho que se pede em cada uma das propostas seguintes, considere que deve, em qualquer um dos casos, realizar a seguinte lista de tarefas:
1. Especi􏰂car os padrões de frases que quer encontrar no texto-fonte, através de ERs.
2. Identi􏰂car as acções semânticas a realizar como reacção ao reconhecimento de cada um desses padrões.
3. Identi􏰂car as Estruturas de Dados globais que possa eventualmente precisar para armazenar temporariamente a informação que vai extraindo do texto-fonte ou que vai construindo à medida que o processamento avança.
4. Desenvolver um Filtro de Texto para fazer o reconhecimento dos padrões identi􏰂cados e proceder à transformação pretendida, com recurso ao Gerador FLex.
1
2.1 Template multi-􏰂le
Para várias projectos de software, é habitual soluções envolvendo vários 􏰂cheiros, várias pastas. Exemplo: um 􏰂cheiro, uma make􏰂le, um manual, uma pasta de exemplos, etc.
Pretende-se criar um programa "mkfromtemplate", capaz de aceitar um nome de projecto, e um 􏰂cheiro descrição de um template-multi-􏰂le e que crie os 􏰂cheiros e pastas iniciais do projecto.
No exemplo abaixo apresenta-se um template-multi-􏰂le para um projecto geral de um 􏰂ltro 􏰃ex. O template inclui:
• metadados (author, email) a substituir nos elementos seguintes • tree (estrutura de directorias e 􏰂cheiros a criar)
• template da cada 􏰂cheiro
O metadado "name"vai ser processado via argumento de linha de comando. === meta
 email: jj@di.uminho.pt
 author: J.João
 # "name" é dado por argumento de linha de comando (argv[1])
 === tree
 {%name%}/
 - {%name%}.fl
 - doc/
 -- {%name%}.md
 - exemplo/
 - Makefile
=== Makefile
 {%name%}: {%name%}.fl
         flex {%name%}.fl
         cc -o {%name%} lex.yy.c
 install: {%name%}
         cp {%name%} /usr/local/bin/
 === {%name%}.md
 # NAME
 {%name%} - o nosso fabuloso filtro ...FIXME
## Synopsis
    {%name%} file*
 ## Description
 ## See also
 ## Author
 Comments and bug reports to {%author%}, {%email%}.
 === {%name%}.fl
 %option noyywrap yylineno
 %%
 %%
 int main(){
yylex();
                                                                                             2

  return 0; }
Modo de executar o programa: mkfromtemplate name template.
Como resultado da execução serão criados os 􏰂cheiros e directorias descritos em tree, com os conteúdos de􏰂nidos nos templates de 􏰂cheiro, e as variáveis substituídas.
