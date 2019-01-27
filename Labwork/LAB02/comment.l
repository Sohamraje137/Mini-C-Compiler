%{ 
int char_number = 0; 
int word_number = 0; 
int spaces_number = 0; 
int newline_number = 0; 
int line_number =0 ;
%} 


%% 
[a-zA-Z0-9]*?\/\/[a-z0-9A-Z]* {  }
\/\*(.*\n)*(.*)\*\/ 

%% 

int yywrap(){} 

int main(int argc, char*argv[]) 
{ 
extern FILE *yyin; 

yyin = fopen("test/test1.c","r");

yylex(); 


return 0; 
} 
