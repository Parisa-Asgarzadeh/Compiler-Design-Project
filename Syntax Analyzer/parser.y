
%{
    #include <stdio.h>
%}

%token TOKEN_INT TOKEN_MAIN TOKEN_LEFTPAREN TOKEN_RIGHTPAREN TOKEN_LEFTB TOKEN_RIGHTB
%token TOKEN_WHILE TOKEN_FOR TOKEN_RETURN TOKEN_CONTINUE TOKEN_BREAK TOKEN_IDENTIFIER
%token NOT_RECOGNIZED
%token TOKEN_INT_CONST TOKEN_INT_CONST_OUT_OF_RANGE TOKEN_STRING TOKEN_LESS TOKEN_MORE
%token TOKEN_LESS_EQUAL TOKEN_MORE_EQUAL TOKEN_EQUAL_TO TOKEN_NOT_EQUAL TOKEN_LOGICAL_OR
%token TOKEN_LOGICAL_AND TOKEN_BITWISE_OR TOKEN_BITWISE_AND TOKEN_BITWISE_XOR TOKEN_NOT 
%token TOKEN_PLUS TOKEN_MINUS TOKEN_MULTIPLY TOKEN_DIVISION
%token TOKEN_LEFT_BRACKET TOKEN_RIGHT_BRACKET TOKEN_COMMA
%token TOKEN_DOT TOKEN_ASSIGN TOKEN_CHAR TOKEN_IF TOKEN_ELSE TOKEN_ELSEIF TOKEN_VOID

%start file_l

%%
file_l : func_l
        ;
main_l : TOKEN_INT TOKEN_MAIN TOKEN_LEFTPAREN TOKEN_RIGHTPAREN TOKEN_LEFTB expr TOKEN_RIGHTB
        | TOKEN_VOID TOKEN_MAIN TOKEN_LEFTPAREN TOKEN_RIGHTPAREN TOKEN_LEFTB expr TOKEN_RIGHTB
        ;
func_l : type_l TOKEN_IDENTIFIER TOKEN_LEFTPAREN arg_l TOKEN_RIGHTPAREN TOKEN_LEFTB expr TOKEN_RIGHTB func_l
        | main_l
        ;
type_l : TOKEN_VOID
            | TOKEN_INT
            | TOKEN_CHAR
            ;        
arg_l : 
        | int_char_l TOKEN_IDENTIFIER
        | int_char_l TOKEN_IDENTIFIER TOKEN_COMMA int_char_l TOKEN_IDENTIFIER
        | int_char_l TOKEN_IDENTIFIER TOKEN_COMMA int_char_l TOKEN_IDENTIFIER TOKEN_COMMA int_char_l TOKEN_IDENTIFIER
        ;
Func_call_l :
        | TOKEN_IDENTIFIER
        | TOKEN_IDENTIFIER TOKEN_COMMA TOKEN_IDENTIFIER
        | TOKEN_IDENTIFIER TOKEN_COMMA TOKEN_IDENTIFIER TOKEN_COMMA TOKEN_IDENTIFIER
        ;
int_char_l : TOKEN_INT
                | TOKEN_CHAR
return_l : TOKEN_RETURN w_return_l TOKEN_DOT
            ;
w_return_l : 
                | TOKEN_IDENTIFIER
                | TOKEN_INT_CONST
                | TOKEN_STRING
                ;

if_l : TOKEN_IF TOKEN_LEFTPAREN condition TOKEN_RIGHTPAREN TOKEN_LEFTB expr TOKEN_RIGHTB else_l
        ;
else_l :        
            | TOKEN_ELSEIF TOKEN_LEFTPAREN condition TOKEN_RIGHTPAREN TOKEN_LEFTB expr TOKEN_RIGHTB else_l
            | TOKEN_ELSE TOKEN_LEFTB expr TOKEN_RIGHTB
            ;

condition : TOKEN_LEFTPAREN condition TOKEN_RIGHTPAREN  // (c)
            | condition TOKEN_LOGICAL_AND condition     // c && c
            | condition TOKEN_LOGICAL_OR condition      // c || c
            | TOKEN_NOT condition                       // ! c
            | condition compare condition
            | A  
            | TOKEN_STRING                       
        //     | TOKEN_IDENTIFIER TOKEN_EQUAL_TO TOKEN_STRING 
        //     | TOKEN_STRING TOKEN_NOT_EQUAL TOKEN_IDENTIFIER 
        //     | TOKEN_IDENTIFIER TOKEN_NOT_EQUAL TOKEN_STRING 
        //     | TOKEN_STRING TOKEN_EQUAL_TO TOKEN_IDENTIFIER 
        //     | TOKEN_STRING TOKEN_NOT_EQUAL TOKEN_STRING 
        //     | TOKEN_STRING TOKEN_EQUAL_TO TOKEN_STRING
            ;

compare : TOKEN_EQUAL_TO
            | TOKEN_MORE
            | TOKEN_LESS_EQUAL
            | TOKEN_MORE_EQUAL
            | TOKEN_LESS
            | TOKEN_NOT_EQUAL
            ;

// NUMERICAL CALCULATION
exp1 : A  // ?????
        ;

exp2 : TOKEN_STRING
        | TOKEN_IDENTIFIER
        ;

expr :          
        | if_l expr
        | while_l expr
        | for_l expr
        | assign_l expr
        | return_l expr
        | def_l expr
        ;

expr_loop : 
                // | expr expr_loop
                | if_l expr_loop
                | while_l expr_loop
                | for_l expr_loop
                | assign_l expr_loop
                | return_l expr_loop
                | def_l expr_loop
                | TOKEN_BREAK TOKEN_DOT expr_loop
                | TOKEN_CONTINUE TOKEN_DOT expr_loop
                | if_loop_l expr_loop
                ;

if_loop_l : TOKEN_IF TOKEN_LEFTPAREN condition TOKEN_RIGHTPAREN
                TOKEN_LEFTB expr_loop TOKEN_RIGHTB else_loop_l
                ;

else_loop_l : 
                | TOKEN_ELSEIF TOKEN_LEFTPAREN condition TOKEN_RIGHTPAREN
                  TOKEN_LEFTB expr_loop TOKEN_RIGHTB else_loop_l
                | TOKEN_ELSE TOKEN_LEFTB expr_loop TOKEN_RIGHTB
                ;

while_l : TOKEN_WHILE TOKEN_LEFTPAREN condition TOKEN_RIGHTPAREN TOKEN_LEFTB expr_loop TOKEN_RIGHTB
        ;
// FOR
for_l : TOKEN_FOR TOKEN_LEFTPAREN def_for_l TOKEN_COMMA condition TOKEN_COMMA step_l TOKEN_RIGHTPAREN
        TOKEN_LEFTB expr_loop TOKEN_RIGHTB
        ;

step_l : TOKEN_IDENTIFIER TOKEN_ASSIGN A
        ;

assign_l : int_assi_l
            | char_assi_l
            ;

int_assi_l : TOKEN_INT TOKEN_IDENTIFIER TOKEN_ASSIGN exp1 TOKEN_DOT
        | TOKEN_INT TOKEN_IDENTIFIER TOKEN_ASSIGN TOKEN_IDENTIFIER TOKEN_LEFTPAREN Func_call_l TOKEN_RIGHTPAREN TOKEN_DOT
        | TOKEN_IDENTIFIER TOKEN_ASSIGN exp1 TOKEN_DOT
        | TOKEN_IDENTIFIER TOKEN_ASSIGN TOKEN_IDENTIFIER TOKEN_LEFTPAREN Func_call_l TOKEN_RIGHTPAREN TOKEN_DOT
                ;
char_assi_l : TOKEN_CHAR TOKEN_IDENTIFIER TOKEN_ASSIGN exp2 TOKEN_DOT
                | TOKEN_CHAR TOKEN_IDENTIFIER TOKEN_ASSIGN TOKEN_IDENTIFIER TOKEN_LEFTPAREN Func_call_l TOKEN_RIGHTPAREN TOKEN_DOT
                | TOKEN_IDENTIFIER TOKEN_ASSIGN exp2 TOKEN_DOT
                | TOKEN_IDENTIFIER TOKEN_ASSIGN TOKEN_IDENTIFIER TOKEN_LEFTPAREN Func_call_l TOKEN_RIGHTPAREN TOKEN_DOT
                ;

def_l : TOKEN_INT TOKEN_IDENTIFIER TOKEN_DOT
            | TOKEN_CHAR TOKEN_IDENTIFIER TOKEN_DOT
            ;

def_for_l : TOKEN_INT TOKEN_IDENTIFIER
                | TOKEN_INT TOKEN_IDENTIFIER TOKEN_ASSIGN A
                ;

//operations
// OR
A : C B 
        ;
B : 
        | TOKEN_BITWISE_OR C B
        ;
// XOR
C : E D
        ;
D : 
        | TOKEN_BITWISE_XOR E D
        ;
// AND
E : G F
        ;
F : 
        | TOKEN_BITWISE_AND G F
        ;
// PLUS MINUS
G : I H
        ;
H :
        | TOKEN_PLUS I H
        | TOKEN_MINUS I H
        ;
// MUL DIV
I : K J
        ;        
J : 
        | TOKEN_MULTIPLY K J
        | TOKEN_DIVISION K J
        ;
// PAREN NUMBER
K : TOKEN_LEFTPAREN A TOKEN_RIGHTPAREN
        | TOKEN_IDENTIFIER
        | TOKEN_INT_CONST
        ;


%%

void yyerror(char *s){
        printf ("Error Happened %s\n",s);
}
int yywrap(){
        return 1;
}
int main(void){
        yyparse();
}