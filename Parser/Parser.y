%{
#include <stdio.h>
#include <stdlib.h>
#include "../AST/ AST.c"

extern int yylex();


%}

%parse-param{struct Node** AST}

%union {
  int ivalue;
  float fvalue;
  char* cvalue;
  struct Node *NodeValue;
  enum VariableType varTypeVal;
}

%token EOL                               // \n
%token ADD MINUS MULTIPLY DIVIDE         // + - * /
%token OP CP OBRACE CBRACE               // ( ) { }
%token DOT COMMA COLON                   // . ; :
%token START_OF_DEF END_OF_DEF
%token VOID              
%token TYPE_INT TYPE_FLOAT TYPE_STRING   // types  int float string
%token ASSIGN RETURN PRINT

%token <ivalue> INT
%token <fvalue> FLOAT
%token <cvalue> STRING

%type <NodeValue> start 
%type <NodeValue> defs define_var define_function 
%type <NodeValue> body_line functionArguments function_body functionCallArguments
%type <NodeValue> exp function_call print return assignement
%type <NodeValue> void name constant 


%%

//Etape 1 : on démarre le parsing de l'AST

Beatles: start {*AST = $1; }        
  |EOL start {*AST = $2; }
  ;

//Il faut définir start, ie définir la racine 

start: START_OF_DEF defs EOL END_OF_DEF EOL {$$ = CreateNode(Root, NULL, $2, NULL, NULL)}

//On peut définir soit des fonctions, soit des variables :


defs: define_var EOL defs {$$ = CreateNode(Definition NULL, $1, $3, NULL)}
  | define_var EOL {$$ = CreateNode(Definition, NULL, $1 ,NULL, NULL)}
  | define_function EOL defs {$$ = CreateNode(Definition, NULL, $1, $3, NULL)}
  | define_function  EOL {$$ = CreateNode(Definition, NULL, $1, NULL, NULL)}
  ;

   /************* Définition de variables ************/

//On détaille en 1er la facon dont on parse la définition de variables:
//On a choisi d'écrire comme en C : "int a = 4"

define_var: TYPE_INT name ASSIGN INT {struct Node *DefVarNode = CreateNode(VariableDef, Integer, $2, NULL, NULL); DefIntNode->I = $4; $$ = DefIntNode; }
  | TYPE_STRING name ASSIGN STRING {struct Node *DefVarNode = CreateNode(VariableDef, String, $2, NULL, NULL); DefNode->C = $4; $$ = DefStringNode; }
  | TYPE_FLOAT name ASSIGN FLOAT{struct Node *DefVarNode = CreateNode(VariableDef, Float, $2, NULL, NULL);DefNode->F = $4;$$ = DefFloatNode; }
  ;

   /************* Définition de fonctions ************/

//On détaille maintenant la définition de fonctions :
//On fait aussi comme en C = int f(a,b,c){...}

define_function: TYPE_INT name OP functionArguments CP OBRACE EOL function_body EOL CBRACE{struct Node *DefFunctionNode = CreateNode(FunctionDef, Integer, $2, $4, $8);$$ = DefIntFunctionNode; }
  | TYPE_FLOAT name OP functionArguments CP OBRACE EOL function_body EOL CBRACE{struct Node *DefFunctionNode = CreateNode(FunctionDef, Float, $2, $4, $8);$$ = DefFloatFunctionNode; }
  | TYPE_STRING name OP functionArguments CP OBRACE EOL function_body EOL CBRACE{struct Node *DefFunctionNode = CreateNode(FunctionDef, String, $2, $4, $8);$$ = DefStringFunctionNode; }
  ;

// On détaille ce qu'est l'argument d'une fonction : on a choisi de l'écrire "int a" par exemple
  
functionArguments: void {$$ = $1; }  //Ca peut être un void
  | TYPE_INT name {struct Node *FunctionArgNode = CreateNode(FunctionDefArg, Integer, $2, NULL, NULL);$$ = FunctionArgNode; }
  | TYPE_FLOAT name{struct Node *FunctionArgNode = CreateNode(FunctionDefArg, Float, $2, NULL, NULL);$$ = FunctionArgNode; }
  | TYPE_STRING name{struct Node *FunctionArgNode = CreateNode(FunctionDefArg, String, $2, NULL, NULL);$$ = FunctionArgNode; }
  ;

// Reste à détailler function_body : c'est une succession de plein de body_line

function_body: body_line EOL function_body {$$ = CreateNode(FunctionLine, NULL, $1, $3, NULL); }
  ;

// Et on arrive enfin au gros du problème : détailler une body_line
// Ca peut etre une expression, un assignement, un test, un appel de fct, un début de while,...
// Ils sont définis plus loin dans le parser.

body_line: exp { $$ = $1; }               //l. 111 - 116
  | assignement  { $$ = $1; }              //l. 105 -107
  | function_call { $$ = $1; }            //l. 120 - 128
  | print  { $$ = $1; }                   //l. 133 -
  | return  { $$ = $1; }
  ;  

  /************* Définition d'une ligne du corps de fonction ************/

// Un assignement est de type a=3, ou x=a, 
// avec a et x déjà définis dans le début du code, ds la partie "definitions"
  
assignement: name ASSIGN exp {$$ = CreatNode(Assignement, NULL, $1, $3, NULL); }
  | name ASSIGN name {$$ = CreatNode(Assignement, NULL, $1, $3, NULL); }
  ;

// On definit mtn ce qu'est une expression en général:

exp: exp ADD exp { $$ = CreateNode(Plus, NULL, $1, $3, NULL); }
  | exp MINUS exp { $$ = CreateNode(Minus, NULL, $1, $3, NULL); }
  | exp MULTIPLY exp { $$ = CreateNode(Multiply, NULL, $1, $3, NULL); }
  | exp DIVIDE exp { $$ = CreateNode(Divide, NULL, $1, $3, NULL); }
  ;

//On peut aussi appeler une fonction dans une fonction :

function_call: name OP functionCallArguments CP {$$ = CreateNode(FunctionCall, NULL, $1, $3, NULL); }
  ;

//On définit la liste d'arguments de cette fonction :
functionCallArguments: void {$$ = $1; }
  | name { $$ = CreateNode(FunctionCallArguments, NULL, $1, NULL, NULL); }
  | constant {$$ = CreateNode(FunctionCallArguments, NULL, $1, NULL, NULL); }
  | name COMMA functionCallArguments {$$ = CreateNode(FunctionCallArguments, NULL, $1, $3, NULL);}
  | constant COMMA functionCallArguments {$$ = CreateNode(FunctionCallArguments, NULL, $1, $3, NULL);}
  ;

//On peut aussi utiliser print :

print: PRINT constant { $$ = CreateNode(Print, NULL, $2, NULL, NULL); }
  | PRINT TYPE_INT name { $$ = CreateNode(Print, Int, $3, NULL, NULL); }
  | PRINT TYPE_FLOAT name { $$ = CreateNode(Print, Float, $3, NULL, NULL); }
  | PRINT TYPE_STRING name { $$ = CreateNode(Print, String, $3, NULL, NULL); }
  ;
//On définit return x ou return 0:

return: RETURN name{ $$ = CreateNode(Return, NULL, $2, NULL, NULL)}
  | RETURN constant { $$ = CreateNode(Return, NULL, $2, NULL, NULL)}
  ;

// On définit ce qu'est une constante : un paramètre quoi :

constant: INT { struct Node *IntNode = CreateNode(Constant,Integer, NULL, NULL, NULL); IntNode->I = $1; $$ = IntNode }
  | FLOAT { struct Node *FloatNode = CreateNode(Constant,Float, NULL, NULL, NULL); FloatNode->F = $1; $$ = FloatNode; } 
  | STRING {struct Node *StringNode = CreateNode(Constant,String, NULL, NULL, NULL); StringNode->C = $1; $$ = StringNode; }
  ;

name: STRING {struct Node *NameNode = CreateNode(Name, String, NULL, NULL, NULL); NameNode ->C = $1; $$ = NameNode; }
  ;

void: VOID { $$ = CreateNode(Void, NULL, NULL, NULL, NULL); }
  ;

// Reste à faire les boucles while, for et if.
%%