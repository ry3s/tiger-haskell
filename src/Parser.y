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

TyDec:
  type id '=' Ty   { (\(p,s) -> A.TypeDec [(s, $4, p)]) $2 }

Ty:
  id               { (\(p,s) -> A.NameTy s p) $1 }
| '{' TyFields '}' { A.RecordTy $2 }
| array of id      { (\(p,s) -> A.ArrayTy s p) $3 }

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
| id '[' Matched ']' of Matched { undefined }
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
| Compare                 { $1 }

Compare:
  ArithExpr '=' ArithExpr   { A.OpExp $1 A.EqOp $3 ((\(Eq x) -> x) $2)  }
| ArithExpr '<>' ArithExpr  { A.OpExp $1 A.NeqOp $3 ((\(Neq x) -> x) $2) }
| ArithExpr '>' ArithExpr   { A.OpExp $1 A.GtOp $3 ((\(Gt x) -> x) $2) }
| ArithExpr '<' ArithExpr   { A.OpExp $1 A.LtOp $3 ((\(Lt x) -> x) $2) }
| ArithExpr '>=' ArithExpr  { A.OpExp $1 A.GeOp $3 ((\(Ge x) -> x) $2) }
| ArithExpr '<=' ArithExpr  { A.OpExp $1 A.LeOp $3 ((\(Le x) -> x) $2) }
| ArithExpr                 { $1 }

ArithExpr:
  ArithExpr '+' Term        { A.OpExp $1 A.PlusOp $3 ((\(Plus x) -> x) $2) }
| ArithExpr '-' Term        { A.OpExp $1 A.MinusOp $3 ((\(Minus x) -> x) $2) }
| Term                      { $1 }

Term:
  Term '*'  PrefExpr    { A.OpExp $1 A.TimesOp $3 ((\(Times x) -> x) $2) }
| Term '/'  PrefExpr    { A.OpExp $1 A.DivideOp $3 ((\(Divide x) -> x) $2) }
| PrefExpr              { $1 }

PrefExpr:
  '-' PrefExpr           { A.OpExp zero A.MinusOp $2 ((\(Minus x) -> x) $1) }
| Factor                 { $1 }

Factor:
  LValue                { A.VarExp $1 }
| nil                   { A.NilExp }
| '(' ExprSequence ')'  { $2 }
| int                   { (\(p, s) -> A.IntExp s) $1 }
| string                { (\(p, s) -> A.StringExp s p) $1 }
| id '(' CallArgs ')'   { (\(p, s) -> A.CallExp s $3 p) $1 }
| TypeId '{' Fields '}' { (\(p, s) -> A.RecordExp $3 s p) $1 }
| break                 { A.BreakExp ((\(Break x) -> x) $1)}
| let Decs in ExprSequence end { (\(Let p) -> A.LetExp $2 $4 p) $1 }

CallArgs:
  CallArgsTail          { $1 }
| {- empty -}           { [] }

CallArgsTail:
  Expr                  { [$1] }
| Expr ',' CallArgsTail { $1 : $3 }

Fields:
  FieldsTail            { $1 }
| {- empty -}           { [] }

FieldsTail:
  Field                 { [$1] }
| Field ',' FieldsTail  { $1 : $3 }


Field:
 id '=' Expr            { (\(p, s) -> (s, $3, p)) $1 }

ExprSequence:
  ExprSequenceTail { fnExprSequenceToExp $1 }
| {- empty -} { fnExprSequenceToExp [] }

ExprSequenceTail:
  Expr         { [$1] }
| Expr ';' ExprSequenceTail { $1 : $3 }


{
parseError :: [Token] -> Either String a
parseError tokens = Left $ "parse error" ++ show tokens

zero = A.IntExp 0
one = A.IntExp 1

fnExprSequenceToExp :: [A.Exp] -> A.Exp
fnExprSequenceToExp [e] = e
fnExprSequenceToExp es = A.SeqExp [ (e, Pos 0 0) | e <- es ]
}
