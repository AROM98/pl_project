#ifndef _HEAD
#define _ HEAD 1

//estas definiçoes aqui é um exemplo de como podemos usar
#define CREATMD 100
#define CREATDIR 101
#define CREATFL 102
#define CREATMAKE 103
#define CREATREADME 104
#define CREATFICH 105

//vars partilhadas
char* nomefinal;
char* email;
char* autor;
char buffer[1000];
char* dir; //dir tmp
int dflag;

// para criaçao dos ficheiros
char* nomefich;
char* extensao;

#endif