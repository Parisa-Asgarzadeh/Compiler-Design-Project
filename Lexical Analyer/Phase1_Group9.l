%option noyywrap

/*for including or variables*/
%{
    #include <stdio.h>
%}

/*rule section*/
%%
 /* Key words */
"int" {
    fprintf(yyout, "TOKEN_INT\n");
}
"void" {
    fprintf(yyout, "TOKEN_VOID\n");
}
"main" {
    fprintf(yyout, "TOKEN_MAIN\n");
}
"char" {
    fprintf(yyout, "TOKEN_CHAR\n");
}
"if" {
    fprintf(yyout, "TOKEN_IF\n");
}
"else" {
    fprintf(yyout, "TOKEN_ELSE\n");
}
"elseif" {
    fprintf(yyout, "TOKEN_ELSEIF\n");
}
"while" {
    fprintf(yyout, "TOKEN_WHILE\n");
}
"for" {
    fprintf(yyout, "TOKEN_FOR\n");
}
"return" {
    fprintf(yyout, "TOKEN_RETURN\n");
}
"continue" {
    fprintf(yyout, "TOKEN_CONTINUE\n");
}
"break" {
    fprintf(yyout, "TOKEN_BREAK\n");
}

 /* Variable and function names */
(_|[a-zA-Z])(_|[a-zA-Z]|[0-9])* {
    fprintf(yyout, "TOKEN_IDENTIFIER\n");
}

([0-9]*)(_|[a-zA-Z])(_|[a-zA-Z]|[0-9])* {
    fprintf(yyout, "NOT_RECOGNIZED\n");
}


 /* Constant values */
(-)*([1-9][0-9]{0,4}|0) {
    if(atoi(yytext) < 32768 && atoi(yytext) > -32769)
        fprintf(yyout, "TOKEN_INT_CONST\n");
    else
        fprintf(yyout, "TOKEN_INT_CONST_OUT_OF_RANGE\n");
}

(-)*([1-9][0-9]*|0) {
    fprintf(yyout, "TOKEN_INT_CONST_OUT_OF_RANGE\n");
}

["][^"]*["] {
    fprintf(yyout, "TOKEN_STRING\n");
}

 /* Multi-line comments */
"#!"([^!]|(!+[^!#])|(\n))*"!#" {

}

 /* One-line comments*/
"#"[^#\n]*"#" {
    
}

 /* Operators */
"<" {
    fprintf(yyout, "TOKEN_LESS\n");
}
">" {
    fprintf(yyout, "TOKEN_MORE\n");
}
"<=" {
    fprintf(yyout, "TOKEN_LESS_EQUAL\n");
}
">=" {
    fprintf(yyout, "TOKEN_MORE_EQUAL\n");
}
"==" {
    fprintf(yyout, "TOKEN_EQUAL_TO\n");
}
"!=" {
    fprintf(yyout, "TOKEN_NOT_EQUAL\n");
}
"||" {
    fprintf(yyout, "TOKEN_LOGICAL_OR\n");
}
"&&" {
    fprintf(yyout, "TOKEN_LOGICAL_AND\n");
}
"|" {
    fprintf(yyout, "TOKEN_BITWISE_OR\n");
}
"&" {
    fprintf(yyout, "TOKEN_BITWISE_AND\n");
}
"^" {
    fprintf(yyout, "TOKEN_BITWISE_XOR\n");
}
"!" {
    fprintf(yyout, "TOKEN_NOT\n");
}
"+" {
    fprintf(yyout, "TOKEN_PLUS\n");
}
"-" {
    fprintf(yyout, "TOKEN_MINUS\n");
}
"*" {
    fprintf(yyout, "TOKEN_MULTIPLY\n");
}
"/" {
    fprintf(yyout, "TOKEN_DIVISION\n");
}

 /* Other tokens */
"(" {
    fprintf(yyout, "TOKEN_LEFTPAREN\n");
}
")" {
    fprintf(yyout, "TOKEN_RIGHTPAREN\n");
}
"{" {
    fprintf(yyout, "TOKEN_LEFTB\n");
}
"}" {
    fprintf(yyout, "TOKEN_RIGHTB\n");
}
"[" {
    fprintf(yyout, "TOKEN_LEFT_BRACKET\n");
}
"]" {
    fprintf(yyout, "TOKEN_RIGHT_BRACKET\n");
}
"," {
    fprintf(yyout, "TOKEN_COMMA\n");
}
"." {
    fprintf(yyout, "TOKEN_DOT\n");
}
"=" {
    fprintf(yyout, "TOKEN_ASSIGN\n");
}

[\n] {

}

[^ ] {
    fprintf(yyout, "NOT_RECOGNIZED\n");
}

. {

}

%%
int main(){
    FILE* input_file = fopen("test_case.txt", "r");
    FILE* output_file = fopen("ans.txt", "w");
    yyin = input_file;
    yyout = output_file;
    yylex();
    return 0;
}