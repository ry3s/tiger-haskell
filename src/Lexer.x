{
module Lexer where

}

%wrapper "posn"

$digit = [0-9]
$lower = [a-z]
$alpha = [a-zA-z]
@ident = $alpha [$alpha $digit \_]*

$u = [ . \n] -- any character


tokens :-

$white +                                    ;
"/*" ([$u # \*] | \* [$u # \/])* ("*")+ "/" ;
while                 {\p s -> While (alexposToPos p)}
for                   {\p s -> For (alexposToPos p)}
to                    {\p s -> To (alexposToPos p)}
break                 {\p s -> Break (alexposToPos p)}
let                   {\p s -> Let (alexposToPos p)}
in                    {\p s -> In (alexposToPos p)}
end                   {\p s -> End (alexposToPos p)}
function              {\p s -> Function (alexposToPos p)}
var                   {\p s -> Var (alexposToPos p)}
type                  {\p s -> Type (alexposToPos p)}
array                 {\p s -> Array (alexposToPos p)}
if                    {\p s -> If (alexposToPos p)}
then                  {\p s -> Then (alexposToPos p)}
else                  {\p s -> Else (alexposToPos p)}
do                    {\p s -> Do (alexposToPos p)}
of                    {\p s -> Of (alexposToPos p)}
nil                   {\p s -> Nil (alexposToPos p)}

","                   {(\p s -> Comma (alexposToPos p))}
":"                   {(\p s -> Colon (alexposToPos p))}
";"                   {(\p s -> Semicolon (alexposToPos p))}
"("                   {(\p s -> LParen (alexposToPos p))}
")"                   {(\p s -> RParen (alexposToPos p))}
"["                   {(\p s -> LBracket (alexposToPos p))}
"]"                   {(\p s -> RBracket (alexposToPos p))}
"{"                   {(\p s -> LBrace (alexposToPos p))}
"}"                   {(\p s -> RBrace (alexposToPos p))}
"."                   {(\p s -> Dot (alexposToPos p))}
"+"                   {(\p s -> Plus (alexposToPos p))}
"-"                   {(\p s -> Minus (alexposToPos p))}
"*"                   {(\p s -> Times (alexposToPos p))}
"/"                   {(\p s -> Divide (alexposToPos p))}
"="                   {(\p s -> Eq (alexposToPos p))}
"<>"                  {(\p s -> Neq (alexposToPos p))}
"<"                   {(\p s -> Lt (alexposToPos p))}
"<="                  {(\p s -> Le (alexposToPos p))}
">"                   {(\p s -> Gt (alexposToPos p))}
">="                  {(\p s -> Ge (alexposToPos p))}
"&"                   {(\p s -> And (alexposToPos p))}
"|"                   {(\p s -> Or (alexposToPos p))}
":="                  {(\p s -> Assign (alexposToPos p))}

\" \"                 {(\p s -> StrLiteral ((alexposToPos p) , unquot s))}
\" ([^\"]|\\ \")* \"  {(\p s -> StrLiteral ((alexposToPos p) , unquot s))}

$digit+               {(\p s -> IntLiteral ((alexposToPos p) ,read s :: Integer))}

@ident                {(\p s -> Id ((alexposToPos p), s))}

{
data Pos = Pos { line :: !Int, column :: !Int } deriving (Show, Eq)

alexposToPos :: AlexPosn -> Pos
alexposToPos (AlexPn _ line column) = Pos line column

data Token =
  -- reserved words
    While Pos
  | For Pos
  | To Pos
  | Break Pos
  | Let Pos
  | In Pos
  | End Pos
  | Function Pos
  | Var Pos
  | Type Pos
  | Array Pos
  | If Pos
  | Then Pos
  | Else Pos
  | Do Pos
  | Of Pos
  | Nil Pos
  -- punctuation synbols
  | Comma Pos
  | Colon Pos
  | Semicolon Pos
  | LParen Pos
  | RParen Pos
  | LBracket Pos
  | RBracket Pos
  | LBrace Pos
  | RBrace Pos
  | Dot Pos
  | Plus Pos
  | Minus Pos
  | Times Pos
  | Divide Pos
  | Eq Pos
  | Neq Pos
  | Lt Pos
  | Le Pos
  | Gt Pos
  | Ge Pos
  | And Pos
  | Or Pos
  | Assign Pos
  --
  | StrLiteral (Pos, String)
  | IntLiteral (Pos, Integer)
  | Id (Pos, String)
  | Eof Pos
  deriving (Eq, Show)

unquot (x:xs) = init xs
}
