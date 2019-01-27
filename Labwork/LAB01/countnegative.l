/* Program to add line numbers 
to a given file*/
%{ 
int neg_count = 0; 
int pos_count=0;
int posfra_count=0;
int negfra_count=0;
%} 



%% 
-[0-9]*[.][0-9]+ {negfra_count++;} 
[0-9]*[.][0-9]+ {posfra_count++;}
[0-9]+ {pos_count++;}
-[0-9]+ {neg_count++;}
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

printf("The number of  negative integers %d\n",neg_count);
printf("\nThe number of  positive integers %d\n",pos_count);

printf("\nThe number of  negative fractions %d\n",negfra_count);
printf("\nThe number of  positive fractions %d\n",posfra_count);

return 0; 
}