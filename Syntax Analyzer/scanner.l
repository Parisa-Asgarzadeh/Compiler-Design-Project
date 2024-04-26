%{
    #include "parser.tab.h"
    #include <stdlib.h>
%}

/*rule section*/
%%
 /* Key words */
"int" {
    return(TOKEN_INT);
}
"void" {
    return(TOKEN_VOID);
}
"main" {
    return(TOKEN_MAIN);
}
"char" {
    return(TOKEN_CHAR);
}
"if" {
    return(TOKEN_IF);
}
"else" {
    return(TOKEN_ELSE);
}
"elseif" {
    return(TOKEN_ELSEIF);
}
"while" {
    return(TOKEN_WHILE);
}
"for" {
    return(TOKEN_FOR);
}
"return" {
    return(TOKEN_RETURN);
}
"continue" {
    return(TOKEN_CONTINUE);
}
"break" {
    return(TOKEN_BREAK);
}

 /* Variable and function names */
(_|[a-zA-Z])(_|[a-zA-Z]|[0-9])* {
    return(TOKEN_IDENTIFIER);
}

([0-9]*)(_|[a-zA-Z])(_|[a-zA-Z]|[0-9])* {
    return(NOT_RECOGNIZED);
}


 /* Constant values */
(-)*([1-9][0-9]{0,4}|0) {
    if(atoi(yytext) < 32768 && atoi(yytext) > -32769)
        return(TOKEN_INT_CONST);
    else
        return(TOKEN_INT_CONST_OUT_OF_RANGE);
}

(-)*([1-9][0-9]*|0) {
    return(TOKEN_INT_CONST_OUT_OF_RANGE);
}

["][^"]*["] {
    return(TOKEN_STRING);
}

 /* Multi-line comments */
"#!"([^!]|(!+[^!#])|(\n))*"!#" {

}

 /* One-line comments*/
"#"[^#\n]* {
    
}

 /* Operators */
"<" {
    return(TOKEN_LESS);
}
">" {
    return(TOKEN_MORE);
}
"<=" {
    return(TOKEN_LESS_EQUAL);
}
">=" {
    return(TOKEN_MORE_EQUAL);
}
"==" {
    return(TOKEN_EQUAL_TO);
}
"!=" {
    return(TOKEN_NOT_EQUAL);
}
"||" {
    return(TOKEN_LOGICAL_OR);
}
"&&" {
    return(TOKEN_LOGICAL_AND);
}
"|" {
    return(TOKEN_BITWISE_OR);
}
"&" {
    return(TOKEN_BITWISE_AND);
}
"^" {
    return(TOKEN_BITWISE_XOR);
}
"!" {
    return(TOKEN_NOT);
}
"+" {
    return(TOKEN_PLUS);
}
"-" {
    return(TOKEN_MINUS);
}
"*" {
    return(TOKEN_MULTIPLY);
}
"/" {
    return(TOKEN_DIVISION);
}

 /* Other tokens */
"(" {
    return(TOKEN_LEFTPAREN);
}
")" {
    return(TOKEN_RIGHTPAREN);
}
"{" {
    return(TOKEN_LEFTB);
}
"}" {
    return(TOKEN_RIGHTB);
}
"[" {
    return(TOKEN_LEFT_BRACKET);
}
"]" {
    return(TOKEN_RIGHT_BRACKET);
}
"," {
    return(TOKEN_COMMA);
}
"." {
    return(TOKEN_DOT);
}
"=" {
    return(TOKEN_ASSIGN);
}

[\n] {

}

[^ ] {
    fprintf(yyout, "NOT_RECOGNIZED\n");
}

. {

}

%%

/* int main(){
    FILE* input_file = fopen("test_case.txt", "r");
    FILE* output_file = fopen("ans.txt", "w");
    yyin = input_file;
    yyout = output_file;
    yylex();
    return 0;
} */