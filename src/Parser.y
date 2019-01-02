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

%%

Program:
Expr  {}

Decs:
  TyDec {}
| VarDec {}
| FunDec {}
| {- empty -} {}

TyDec: type id '=' Ty {}

Ty:
  id {}
| '{' TyFields '}' {}
| array of id     {}

TyFields:
  id ':' id TyFieldsTail {}
| {- empty -}        {}

TyFieldsTail:
  ',' id ':' id TyFieldsTail {}
| {- empty -}       {}

VarDec:
  var id ':=' Expr {}
| var id ':' id ':=' Expr {}

FunDec:
  function id '(' TyFields ')' '=' Expr {}
| function id '(' TyFields ')' ':' id '=' Expr {}

LValue:
  id {}
| LValue2  {}

LValue2:
  id '.' id {}
| LValue2 '.' id {}
| id '[' Expr ']' {}
| LValue2 '[' Expr ']' {}

Expr:
  LValue {}
| nil    {}
| '(' ExprSequence ')' {}
| '(' ')'              {}
| int               {}
| string  {}
| '-' Expr {}
| id '(' Args ')' {}

| Expr '+' Expr   {}
| Expr '-' Expr   {}
| Expr '*' Expr   {}
| Expr '/' Expr   {}

| Expr '=' Expr   {}
| Expr '<>' Expr   {}
| Expr '>' Expr   {}
| Expr '<' Expr   {}
| Expr '>=' Expr   {}
| Expr '<=' Expr   {}

| Expr '&' Expr {}
| Expr '|' Expr {}

| id '{' Record '}'  {}
| id '[' Expr ']' of Expr {}

| LValue ':=' Expr {}
| if Expr then Expr else Expr {}
| if Expr then Expr {}
| while Expr do Expr {}
| for id ':=' Expr to Expr do Expr {}
| break                   {}
| let Decs in ExprSequence end {}
| '(' Expr ')'  {}

ExprSequence:
  Expr ExprSequenceTail {}
| {- empty -} {}

ExprSequenceTail:
  ';' Expr ExprSequenceTail {}
| {- empty -}       {}

Args:
  Expr ArgsTail {}
| {- empty -}   {}

ArgsTail:
  ',' Expr ArgsTail {}
| {- empty -}     {}

Record:
  id '=' Expr RecordTail {}
| {- empty -}            {}

RecordTail:
  ',' id '=' Expr RecordTail {}
| {- empty -}    {}

{
parseError :: [Token] -> Either String a
parseError tokens = Left $ "parse error" ++ show tokens
}
