// bvwelch 23 jan, '10

// you may prefer to view this file from the 'ANTLRWorks' GUI tool, 
// which is a single Java 'jar' file, from here: http://www.antlr.org/works/index.html

// If you want to run the test program, jaltest.py, then you need to 
// generate the lexer and parser first, like this:
//    java -cp antlr-3.1.2.jar org.antlr.Tool jal.g 

// this first cut of JAL grammar was derived from an example found 
// here: http://www.antlr.org/wiki/display/ANTLR3/Example

grammar jal;

options {
	language=Python;
	output=AST;
	ASTLabelType=CommonTree;
}

program : ( statement {print $statement.tree.toStringTree();} )+ ;

statement :	
        block_stmt | for_stmt | forever_stmt | if_stmt 
        | repeat_stmt | while_stmt | case_stmt
        | var_def | const_def | alias_def
        | proc_def | pseudo_proc_def
        | func_def | pseudo_func_def
        | 'return' expr
        | 'assert' expr
        | 'include' IDENTIFIER
        | '_debug' STRING_LITERAL
        | '_error' STRING_LITERAL
        | '_warn' STRING_LITERAL
	| IDENTIFIER '=' expr
	;

// FIXME
cexpr   :   constant
        ;

cexpr_list : '{' cexpr ( ',' cexpr ) '}'
	;
	
for_stmt : 'for' expr ( 'using' IDENTIFIER )* 'loop' 
                statement+
                ( 'exit' 'loop' )*
            'end' 'loop'
        ;

forever_stmt : 'forever' 'loop' 
                statement+
                ( 'exit' 'loop' )*
            'end' 'loop'
        ;

while_stmt : 'while' expr 'loop' 
                statement+
                ( 'exit' 'loop' )*
            'end' 'loop'
        ;

repeat_stmt : 'repeat'
                statement+
                ( 'exit' 'loop' )*
            'until' expr
        ;

if_stmt : 'if' expr 'then' statement+
            ('elsif' expr 'then' statement+ )*
            ('else' statement+ )*
            'end' 'if'
        ;

case_stmt : 'case' expr 'of'
                cexpr (',' cexpr)* ':' statement
                ( cexpr (',' cexpr)* ':' statement )*
                ('otherwise' statement)*
            'end' 'case'
        ;

block_stmt : 'block' statement+ 'end' 'block' ;

proc_def : 'procedure' IDENTIFIER '(' proc_parm (',' proc_parm)* ')' 'is'
                statement+
            'end' 'procedure'
    ;

func_def : 'function' IDENTIFIER '(' proc_parm (',' proc_parm)* ')' 'is'
                statement+
            'end' 'function'
    ;

proc_parm : 'volatile'* type ( IN | 'out' | IN 'out' ) IDENTIFIER
    ;

pseudo_proc_def : 'procedure' IDENTIFIER '\'' 'put' '(' type IN IDENTIFIER ')' 'is'
                statement+
            'end' 'procedure'
    ;

pseudo_func_def : 'function' IDENTIFIER '\'' 'get' 'return' type 'is'
                statement+
            'end' 'function'
    ;

IN : 'in' ;

alias_def : 'alias' IDENTIFIER 'is' IDENTIFIER
        ;

const_def : 'const' vtype* IDENTIFIER ( '[' cexpr* ']' )* '='
            ( cexpr | cexpr_list | IDENTIFIER | STRING_LITERAL )
        ;

var_def : var_decl1 var_decl2 (var_multi* | at_decl | is_decl | var_with_init)
        ;

var_multi : ',' var_decl2
        ;

var_with_init : '=' var_init
        ;

var_decl1 : 'var' 'volatile'* vtype
        ;

var_decl2 : IDENTIFIER ( '[' cexpr* ']' )*
        ;

vtype   :   type ('*' constant)*
        ;

at_decl : ('shared')* 'at' ( ( cexpr bitloc* ) | (  IDENTIFIER bitloc* ) | cexpr_list )
        ;

is_decl : 'is' IDENTIFIER
        ;

bitloc  : ':' constant
        ;

//FIXME: this is wrong-- add proc/func calls to the expr handler instead
proc_func_call   : IDENTIFIER '(' IDENTIFIER* ')'
        ;

var_init : proc_func_call | cexpr | cexpr_list | STRING_LITERAL | CHARACTER_LITERAL | IDENTIFIER
        ;

type    :       'bit' | 'byte' | 'word' | 'dword' 
        | 'sbyte' | 'sword' | 'sdword'
        ;

PRAGMA
    : 'pragma' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    ;

// all below-- borrowed/derived from Antlr C.g and Python.g examples.

//or_test : and_test ('|' and_test)*
//        ;
//
//and_test : not_test ('&' not_test)*
//         ;
//
//not_test : '!' not_test
//         | comparison
//         ;
//
//comparison: expr (comp_op expr)*
//          ;
//
//comp_op : '<' | '>' | '==' | '>=' | '<=' | '!='
//        ;
//
expr : xor_expr ('|' xor_expr)*
     ;

xor_expr : and_expr ('^' and_expr)*
         ;

and_expr : shift_expr ('&' shift_expr)*
         ;

shift_expr : arith_expr (('<<'|'>>') arith_expr)*
           ;

arith_expr: term (('+'|'-') term)*
          ;

term : factor (('*' | '/' | '%' ) factor)*
     ;

factor : '+' factor
       | '-' factor
       | '~' factor
       | atom
       ;

atom	:       CHARACTER_LITERAL
        |       STRING_LITERAL
        |       constant
	|	IDENTIFIER
	;

IDENTIFIER : LETTER (LETTER|'0'..'9')* ;

fragment
LETTER : 'A'..'Z' | 'a'..'z' | '_' ;

constant :  BIN_LITERAL | HEX_LITERAL | OCTAL_LITERAL | DECIMAL_LITERAL ;

BIN_LITERAL : '0' ('b'|'B') ('0' | '1' | '_')+ ;

DECIMAL_LITERAL : ('0' | '1'..'9' '0'..'9'*) ;

HEX_LITERAL : '0' ('x'|'X') HexDigit+ ;

OCTAL_LITERAL : '0' ('0'..'7')+ ;

CHARACTER_LITERAL :   '"' ( EscapeSequence | ~('\''|'\\') ) '"'
    ;

STRING_LITERAL :  '"' ( EscapeSequence | ~('\\'|'"') )* '"'
    ;

fragment
HexDigit : ('0'..'9'|'a'..'f'|'A'..'F'|'_') ;

fragment EscapeSequence :   '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\')
    |   OctalEscape
    ;

fragment OctalEscape :   '\\' ('0'..'3') ('0'..'7') ('0'..'7')
    |   '\\' ('0'..'7') ('0'..'7')
    |   '\\' ('0'..'7')
    ;

WS  :  (' '|'\r'|'\t'|'\u000C'|'\n') {$channel=HIDDEN;}
    ;

LINE_COMMENT
    : ('--' | ';') ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    ;

