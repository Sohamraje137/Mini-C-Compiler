/* Program to add line numbers 
to a given file*/
%{ 
int char_number = 0; 
int word_number = 0; 
int spaces_number = 0; 
int newline_number = 0; 

%} 

/* simple name definitions to simplify 
the scanner specification name 
definition of line*/

%% 
([a-zA-Z0-9])* {
        word_number++; 
        char_number+=strlen(yytext);       
        }
\n {newline_number++;}
%% 

int yywrap(){} 

int main(int argc, char*argv[]) 
{ 
extern FILE *yyin; 

/* whenever a line is encountered increment count*/

/* 10 specifies the padding from left side to 
					present the line numbers*/

/* yytext The text of the matched pattern is stored 
						in this variable (char*)*/
// yyin as pointer of File type 

yyin = fopen("test1.c","r"); /* yyin points to the file 
								testtest.c and opens it 
								in read mode.*/

yylex(); // The function that starts the analysis. 

printf("The number of  \n\tcharacters %d \n \tWords \t %d\n  \tNewLine %d \n\tEOF \t 1\n",char_number,word_number,newline_number);
return 0; 
} 
