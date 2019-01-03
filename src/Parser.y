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
string   { StrLiteral  $$ }
int      { IntLiteral  $$ }
id       { Id  $$}
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
Expr  { undefined }

Decs:
  DecsTail  { undefined }

DecsTail:
  Dec DecsTail { undefined }
| {- empty -} { undefined }

Dec:
  TyDec { undefined }
| VarDec { undefined }
| FunDec { undefined }

TyDec: type id '=' Ty { undefined }

Ty:
  id { undefined }
| '{' TyFields '}' { undefined }
| array of id     { undefined }

TyFields:
  TyFieldsTail { undefined }
| {- empty -} { undefined }

TyFieldsTail:
  TyField      { undefined }
| TyField ',' TyFieldsTail { undefined }

TyField:
  id ':' TypeId { undefined }

TypeId:
  id            { undefined }

VarDec:
  var id OptType ':=' Expr { undefined }


OptType:
  ':' TypeId       { undefined }
| {- empty -}      { undefined }

FunDec:
  function id '(' TyFields ')' OptType '=' Expr { undefined }

Expr:
  Matched        { undefined }
| Unmatched      { undefined }

Matched:
  Disjunction           { undefined }
| LValue ':=' Matched { undefined }
| id '[' Matched ']' { undefined }
| if Expr then Matched else Matched { undefined }
| while Expr do Matched            { undefined }
| for id ':=' Expr to Expr do Matched { undefined }

Unmatched:
  LValue ':=' Unmatched    { undefined }
| id '[' Matched ']' of Unmatched  { undefined }
| if Expr then Matched else Unmatched  { undefined }
| if Expr then Matched                  { undefined }
| while Expr do Unmatched              { undefined }
| for id ':=' Expr to Expr do Unmatched { undefined }


LValue:
  id LValue1               { undefined }

LValue1:
  '[' Matched ']' LValue1    { undefined }
| '.' id LValue1            { undefined }
| {- empty -}               { undefined }

Disjunction:
  Disjunction '|' Conjunction      { undefined }
| Conjunction                      { undefined }

Conjunction:
  Conjunction '&' Compare { undefined }
| Compare                 { undefined }

Compare:
  ArithExpr '=' ArithExpr   { undefined }
| ArithExpr '<>' ArithExpr   { undefined }
| ArithExpr '>' ArithExpr   { undefined }
| ArithExpr '<' ArithExpr   { undefined }
| ArithExpr '>=' ArithExpr   { undefined }
| ArithExpr '<=' ArithExpr   { undefined }

ArithExpr:
  ArithExpr '+' Term        { undefined }
| ArithExpr '-' Term        { undefined }

Term:
  Term '*'  PrefExpr    { undefined }
| Term '/'  PrefExpr    { undefined }
| PrefExpr              { undefined }

PrefExpr:
  '-' PrefExpr           { undefined }
| Factor                 { undefined }

Factor:
  LValue                { undefined }
| nil                   { undefined }
| '(' ExprSequence ')'  { undefined }
| int                   { undefined }
| string                { undefined }
| id '(' CallArgs ')'   { undefined }
| TypeId '{' Fields '}' { undefined }
| break                 { undefined }
| let Decs in ExprSequence end { undefined }

CallArgs:
  CallArgsTail           { undefined }
| {- empty -}           { undefined }

CallArgsTail:
  Expr                  { undefined }
| Expr ',' CallArgsTail  { undefined }

Fields:
  FieldsTail             { undefined }
| {- empty -}           { undefined }

FieldsTail:
  Field                 { undefined }
| Field ',' FieldsTail   { undefined }


Field:
 id '=' Expr            { undefined }

ExprSequence:
  ExprSequenceTail { undefined }
| {- empty -} { undefined }

ExprSequenceTail:
  Expr         { undefined }
| Expr ';' ExprSequenceTail { undefined }


{
parseError :: [Token] -> Either String a
parseError tokens = Left $ "parse error" ++ show tokens
}
