{
module Parser where

import Lexer
}

%tokentype { Token }
%error { parseError }
%monad { Either String } { (>>=) } { return }

%name parse

%token
while    { While _ }
for      { For _ }
to       { To _ }
break    { Break _ }
let      { Let _ }
in       { In _ }
end      { End _ }
function { Function _ }
var      { Var _ }
type     { Type _ }
array    { Array _ }
if       { If _ }
then     { Then _ }
else     { Else _ }
do       { Do _ }
of       { Of _ }
nil      { Nil _ }
','      { Comma _ }
':'      { Colon _ }
';'      { Semicolon _ }
'('      { LParen _ }
')'      { RParen _ }
'['      { LBracket _ }
']'      { RBracket _ }
'{'      { LBrace _ }
'}'      { RBrace _ }
'.'      { Dot _ }
'+'      { Plus _ }
'-'      { Minus _ }
'*'      { Times _ }
'/'      { Divide _ }
'='      { Eq _ }
'<>'     { Neq _ }
'<'      { Lt _ }
'<='     { Le _ }
'>'      { Gt _ }
'>='     { Ge _ }
'&'      { And _ }
'|'      { Or _ }
':='     { Assign _ }
string   { StrLiteral _ $$ }
int      { IntLiteral _ $$ }
id       { Id _ $$}
{-
%right of
%nonassoc do
%nonassoc else
%nonassoc ':='
%left '&' '|'
%nonassoc '=' '<>' '<' '<=' '>' '>='
%left '+' '-'
%left '*' '-'
%left UMINUS
-}
%%

Program:
Expr  {}

Decs:
  Decs Dec {}
| {- empty -} {}

Dec:
  TyDec {}
| VarDec {}
| FunDec {}

TyDec: type id '=' Ty {}

Ty:
  id {}
| '{' TyFields '}' {}
| array of id     {}

TyFields:
  TyFieldsRev {}
| {- empty -} {}

TyFieldsRev:
  TyField      {}
| TyFieldsRev ',' TyField {}

TyField:
  id ':' TypeId {}

TypeId:
  id            {}

VarDec:
  var id OptType ':=' Expr {}


OptType:
  ':' TypeId       {}
| {- empty -}      {}

FunDec:
  function id '(' TyFields ')' OptType '=' Expr {}

Expr:
  Matched        {}
| Unmatched      {}

Matched:
  Disjunction           {}
| LValue ':=' Matched {}
| id '[' Matched ']' {}
| if Expr then Matched else Matched {}
| while Expr do Matched            {}
| for id ':=' Expr to Expr do Matched {}

Unmatched:
  LValue ':=' Unmatched    {}
| id '[' Matched ']' of Unmatched  {}
| if Expr then Matched else Unmatched  {}
| if Expr then Matched                  {}
| while Expr do Unmatched              {}
| for id ':=' Expr to Expr do Unmatched {}


LValue:
  id LValue1               {}

LValue1:
  '[' Matched ']' LValue1    {}
| '.' id LValue1            {}
| {- empty -}               {}

Disjunction:
  Disjunction '|' Conjunction      {}
| Conjunction                      {}

Conjunction:
  Conjunction '&' Compare {}
| Compare                 {}

Compare:
  ArithExpr '=' ArithExpr   {}
| ArithExpr '<>' ArithExpr   {}
| ArithExpr '>' ArithExpr   {}
| ArithExpr '<' ArithExpr   {}
| ArithExpr '>=' ArithExpr   {}
| ArithExpr '<=' ArithExpr   {}

ArithExpr:
  ArithExpr '+' Term        {}
| ArithExpr '-' Term        {}

Term:
  Term '*'  PrefExpr    {}
| Term '/'  PrefExpr    {}
| PrefExpr              {}

PrefExpr:
  '-' PrefExpr           {}
| Factor                 {}

Factor:
  LValue                {}
| nil                   {}
| '(' ExprSequence ')'  {}
| int                   {}
| string                {}
| id '(' CallArgs ')'   {}
| TypeId '{' Fields '}' {}
| break                 {}
| let Decs in ExprSequence end {}

CallArgs:
  CallArgsRev           {}
| {- empty -}           {}

CallArgsRev:
  Expr                  {}
| CallArgsRev ',' Expr  {}

Fields:
  FieldsRev             {}
| {- empty -}           {}

FieldsRev:
  Field                 {}
| FieldsRev ',' Field   {}


Field:
 id '=' Expr            {}

ExprSequence:
  ExprSequenceRev {}
| {- empty -} {}

ExprSequenceRev:
  Expr         {}
| ExprSequenceRev ';' Expr {}


{
parseError :: [Token] -> Either String a
parseError tokens = Left $ "parse error" ++ show tokens
}
