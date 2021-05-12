bison -d mynn.y
flex mynn.l
gcc mynn.tab.c lex.yy.c -lfl -o mynn.exe 