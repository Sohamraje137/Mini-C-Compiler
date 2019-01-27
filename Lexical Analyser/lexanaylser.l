%{
int line_count = 0;
int key_count=0;
int spl_count=0;
int op_count=0;
int log_count=0;
int pre_count=0;
int const_count=0;
int int_count=0;
int float_count=0;
int string_count=0;
%}

digit [0-9]
character [a-zA-Z]
underscore _
space [' ']


%%
\n {line_count++;}
\/\/(.*) { }

[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/] {printf("\n\t Multiline comment \t\t\t\n");}
[/][*][a-zA-Z0-9\n ]*[/][*][a-zA-Z0-9\n ]*[*][/][a-zA-Z0-9\n ]*[*][/] printf("\nNested comment \n");

#include{space}*<{character}{character}*\.h> { printf("\n%s\tHeader\t\t\t\t\tLine Number\t\t%d\n",yytext,line_count+1);pre_count++;}

#define{space}+{character}({character}|{digit}|{underscore}*{space}+)|#define{space}+{character}({character}|{digit}|{underscore})*{space}+{digit}+|#define{space}+{character}({character}|{digit}|{underscore})*{space}+({digit}+)\.({digit}+)|#define{space}+{character}({character}|{digit}|{underscore})*{space}+{character}({character}|{digit}|{underscore})* {
             printf("\n%s\t\tDefine Macro\t\t\t\tLine Number\t\t%d\n",yytext,line_count+1); pre_count++;}

\?|: {printf("\n%s\t\t\tspecial character\t\t\tLine Number\t\t%d\n",yytext,line_count+1);spl_count++;}
#include{space}*<{character}{character}*\.h>; {printf("\nError at line number %d: \n\n %s \n\n",line_count+1,yytext);}

#define{space}+{character}({character}|{digit}|{underscore}*{space}+)|#define{space}+{character}({character}|{digit}|{underscore})*{space}+{digit}+|#define{space}+{character}({character}|{digit}|{underscore})*{space}+({digit}+)\.({digit}+)|#define{space}+{character}({character}|{digit}|{underscore})*{space}+{character}({character}|{digit}|{underscore})*; { printf("\nError at line number %d: \n\n %s \n\n",line_count+1,yytext);}


int|float|char|return|goto|auto|double|int|struct|break|else|long|switch|case|enum|register|typedef|char|extern|return|union|const|float|short|unsigned|continue|for|signed|void|default|goto|sizeof|volatile|do|if|static|while {key_count++;
     printf("\n%s\t\t\tkeyword\t\t\t\t\tLine Count\t\t%d\n",yytext,line_count+1);
    }
\"(.*)\" { printf("%s\t\tString\t\t\t\t\tLine Count\t\t%d\n",yytext,line_count+1);}

\"[^\n|^\"]*[\n] {
            printf("\nError at line number %d: \n\n %s  \t-is an incomplete string\n\n",line_count+1,yytext);
        }
, { printf("\n%s\t\t\tspecial character(comma)\t\tLine_count\t\t%d\n",yytext,line_count+1);spl_count++;}
= {printf("\n%s\t\t\tassignment operator\t\t\tLine Count\t\t%d\n",yytext,line_count+1);
    }
"<"|">"|"<="|">="|"!="|"==" {printf("\n%s\t\t\trelational operator\t\t\tLine Count\t\t%d\n",yytext,line_count+1);op_count++;
            }
&&|"||"|! {printf("\n%s\t\t\tlogical operator\t\t\t\tLine Count\t\t%d\n",yytext,line_count+1);log_count++;
            }

[+-/*%]  {printf("\n%s\t\t\tarithmetic operator\t\t\tLine Count\t\t%d\n",yytext,line_count+1);
            }
[" "+|{|}|\t] {}
[_a-zA-Z][A-Za-z0-9_]* {
                                 printf("\n%s\t\t\tidentifier\t\t\t\tLine Count\t\t%d\n",yytext,line_count+1);
                            }
[a-zA-Z0-9]*?\/\/[a-z0-9A-Z]* {  }

{ {printf("\n%s\t\t\tspecial character(open brace)\t\tLine Count\t\t%d\n",yytext,line_count+1);spl_count++;}
} {printf("\n%s\t\t\tspecial character-close bracet\t\tLine Count\t\t%d\n",yytext,line_count+1);spl_count++;}

\( {printf("\n%s\t\t\tspecial character-open parenthesis\tLine Count\t\t%d\n",yytext,line_count+1);spl_count++;}
\) {printf("\n%s\t\t\tspecial character-close parenthesis\tLine Count\t\t%d\n",yytext,line_count+1);spl_count++;}

; {printf("\n%s\t\t\tspecial character-semicolon\t\tLine Count\t\t%d\n",yytext,line_count+1);spl_count++;}
    
[+-]?[0-9]+ {printf("\n%s\t\t\tinteger constant\t\t\tLine Count\t\t%d\n",yytext,line_count+1);int_count++;}
[+-]?[0-9]+"."[0-9]*|[+-]?[0-9]*"."[0-9]+ {printf("\n%s\t\t\tfloating point constant\t\t\tLine Count\t\t%d\n",yytext,line_count+1);float_count++;}
     /* ["for"]{space}* \( ({character}{digit}('=')(' '))*  \; ({character}{digit}('=')('<')('>')('!')(' '))* \;  ({character}{digit}('+')('-')('*')('\')('|')('=')(' '))* \) ('{') (^('}')*\n)* ('}') {  printf("for is a ");}
 
    ["for"](^})*('}'){ printf("There is an error in syntax of for loop\n"); } */ 

%%

int yywrap(){}
int main(){
 
 yyin = fopen("file2.c","r");
yylex();
printf(" --------------------------------------------------------\n");
printf("|                SYMBOL TABLE                            |\n");
printf(" --------------------------------------------------------\n");

printf("|Number of lines found is                      : %d\t|\n",line_count);
printf("|Number of preprocessor directives found is      : %d\t|\n",pre_count++);
printf("|Number of keywords found                       : %d\t|\n",key_count);
printf("|Number of special characters found           : %d\t|\n",spl_count);
printf("|Number of relational operators found          : %d\t|\n",op_count);
printf("|Number of logical operators found           : %d\t|\n",log_count);
printf("|Number of constants found               : %d\t|\n",const_count);
printf(" --------------------------------------------------------\n\n\n");

printf(" --------------------------------------------------------\n");
printf("|             CONSTANT TABLE                             |\n");
printf(" --------------------------------------------------------\n");

printf("|Number of integer constants found                 : %d\t|\n",int_count);
printf("|Number of float constants found                 : %d\t|\n",float_count);
printf("|Number of string constants found                 : %d\t|\n",string_count);
printf(" --------------------------------------------------------\n");
return 0;
}
