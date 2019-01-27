%{ 
int char_number = 0; 
int word_number = 0; 
int spaces_number = 0; 
int newline_number = 0; 
int line_number =0 ;
%} 
list define
%% 
'#include' line_number++;
#[a-z]+[(' ')*]+([a-zA-Z]*[(' ')*[a-zA-Z0-9]*]*|[<[a-z]+>]*); { printf("Error");}
#[a-z]+[(' ')*]+([a-zA-Z]*[(' ')*[a-zA-Z0-9]*]*|[<[a-z]+>]*) { printf("%10s", yytext);}
[a-zA-Z0-9]* {}
[-./*;] {}


%% 

int yywrap(){} 

int main(int argc, char*argv[]) 
{ 
extern FILE *yyin; 

yyin = fopen("test/test1.c","r");

yylex(); 


return 0; 
} 
