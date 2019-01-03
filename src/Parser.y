{
module Parser where

import Lexer
import qualified Absyn as A
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
Expr  { $1 }

Decs:
  DecsTail  { $1 }

DecsTail:
  Dec DecsTail { $1 : $2 }
| {- empty -}  { [] }

Dec:
  TyDec  { $1 }
| VarDec { $1 }
| FunDec { $1 }

TyDec: type id '=' Ty { undefined }

Ty:
  id               { undefined }
| '{' TyFields '}' { undefined }
| array of id      { undefined }

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
  Matched        { $1 }
| Unmatched      { $1 }

Matched:
  Disjunction           { $1 }
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
  Disjunction '|' Conjunction      { A.IfExp $1 one (Just $3) ((\(Or x) -> x) $2) }
| Conjunction                      { $1 }

Conjunction:
  Conjunction '&' Compare { A.IfExp $1 $3 (Just zero) ((\(And x) -> x) $2) }
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

zero = A.IntExp 0
one = A.IntExp 1

}
