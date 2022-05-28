#include <stdio.h>
#include <stdlib.h>

/* We will start by defining what is a "node" in the AST : it can
   be a +, a *, the start of a while, a OR, etc... */

/* Lets enumerate all the possible places of nodes : 
   It defines the place of the node in the tree*/

enum NodePlaces
{
    Root,                                               //Start of the tree                      
        Definition,                                     //Right after the start, we define
            VariableDef, FunctionDef,                   //Either a var or a function
                            FunctionDefArg,
                            FunctionLine,
                                Assignement,
                                Break, Continue, Return,

    FunctionCall, FunctionCallArguments, 
    Plus, Minus, Multiply, Divide,                     //Calcul types
    Equal, Different, Greater, Lesser,                 //Comparaison types
    And, Or,                                           //Logical types
}

enum VariableTypes
{
    Integer,
    Float,
    String,
};

/* Now we can properly define a node : It's a structure that can have :
        - A place in the tree
        - 
        - A value (int or float or a char*)
        - Childs (let's say maximum 3 children)
*/

struct Node
{
    enum NodePlaces Place;    //Place of the node in the tree, among those listed above
    enum VariableTypes Var_Type;
    int I;
    float F;
    char* C;
    struct Node *Child1;    //Possible childs
    struct Node *Child2;
    struct Node *Child3;
};

/* Now that we have our node, we need a function to create it */
/* Our AST will be a Node* */

struct Node* CreateNode (enum NodePlaces place, enum VariableTypes var_type, struct Node *child1,struct Node *child2,struct Node *child3,)
{
    struct Node *node = (struct Node*)malloc(sizeof(struct Node));
    node->Place = place;
    node->Var_Type = var_type;
    node->Child1 = child1;
    node->Child2 = child2;
    node->Child3 = child3;

    return node;
}

void FreeAST (struct NodePlaces* AST)
{
    if (AST == NULL)
        return;
    
    FreeAST(AST->Child1);
    FreeAST(AST->Child2);
    FreeAST(AST->Child3);

    if (AST->C != NULL)
        free(AST->C);
    
    free(ast);
}



