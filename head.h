#ifndef _HEAD
#define _ HEAD 1
#include <glib.h>

//meta dados
char* nomefinal;
char* email;
char* autor;
char buffer[1000];
char* dir; //dir tmp


//para a tree
typedef char* tree[50];

typedef GHashTable* tabela;


// para criaçao dos ficheiros
char* nomefich;
char* extensao;

int contatracos(char* string);
void putinTree(tree t, char* string, int i);
void createfich(char* nome, char* path);

char* STRCAT (char* dest, const char* src);

char *strdup(const char *str);

#endif
