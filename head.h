#ifndef _HEAD
#define _ HEAD 1
#include <glib.h>
//estas definiçoes aqui é um exemplo de como podemos usar

#define CREATDIR 101
#define CREATFICH 105

//vars partilhadas
char* nomefinal;
char* email;
char* autor;
char buffer[1000];
char* dir; //dir tmp
int dflag;

//para a tree
typedef char* tree[50];

typedef GHashTable* tabela;


// para criaçao dos ficheiros
char* nomefich;
char* extensao;

int contatracos(char* string);
void putinTree(tree t, char* string, int i);
void createfich(char* nome, char* tmp, tree t);

char* STRCAT (char* dest, const char* src);


#endif



