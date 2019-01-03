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
while                 {\p s -> While p}
for                   {\p s -> For p}
to                    {\p s -> To p}
break                 {\p s -> Break p}
let                   {\p s -> Let p}
in                    {\p s -> In p}
end                   {\p s -> End p}
function              {\p s -> Function p}
var                   {\p s -> Var p}
type                  {\p s -> Type p}
array                 {\p s -> Array p}
if                    {\p s -> If p}
then                  {\p s -> Then p}
else                  {\p s -> Else p}
do                    {\p s -> Do p}
of                    {\p s -> Of p}
nil                   {\p s -> Nil p}

","                   {(\p s -> Comma p)}
":"                   {(\p s -> Colon p)}
";"                   {(\p s -> Semicolon p)}
"("                   {(\p s -> LParen p)}
")"                   {(\p s -> RParen p)}
"["                   {(\p s -> LBracket p)}
"]"                   {(\p s -> RBracket p)}
"{"                   {(\p s -> LBrace p)}
"}"                   {(\p s -> RBrace p)}
"."                   {(\p s -> Dot p)}
"+"                   {(\p s -> Plus p)}
"-"                   {(\p s -> Minus p)}
"*"                   {(\p s -> Times p)}
"/"                   {(\p s -> Divide p)}
"="                   {(\p s -> Eq p)}
"<>"                  {(\p s -> Neq p)}
"<"                   {(\p s -> Lt p)}
"<="                  {(\p s -> Le p)}
">"                   {(\p s -> Gt p)}
">="                  {(\p s -> Ge p)}
"&"                   {(\p s -> And p)}
"|"                   {(\p s -> Or p)}
":="                  {(\p s -> Assign p)}

\" \"                 {(\p s -> StrLiteral (p , unquot s))}
\" ([^\"]|\\ \")* \"  {(\p s -> StrLiteral (p , unquot s))}

$digit+               {(\p s -> IntLiteral (p ,read s :: Integer))}

@ident                {(\p s -> Id (p, s))}

{

data Token =
  -- reserved words
    While AlexPosn
  | For AlexPosn
  | To AlexPosn
  | Break AlexPosn
  | Let AlexPosn
  | In AlexPosn
  | End AlexPosn
  | Function AlexPosn
  | Var AlexPosn
  | Type AlexPosn
  | Array AlexPosn
  | If AlexPosn
  | Then AlexPosn
  | Else AlexPosn
  | Do AlexPosn
  | Of AlexPosn
  | Nil AlexPosn
  -- punctuation synbols
  | Comma AlexPosn
  | Colon AlexPosn
  | Semicolon AlexPosn
  | LParen AlexPosn
  | RParen AlexPosn
  | LBracket AlexPosn
  | RBracket AlexPosn
  | LBrace AlexPosn
  | RBrace AlexPosn
  | Dot AlexPosn
  | Plus AlexPosn
  | Minus AlexPosn
  | Times AlexPosn
  | Divide AlexPosn
  | Eq AlexPosn
  | Neq AlexPosn
  | Lt AlexPosn
  | Le AlexPosn
  | Gt AlexPosn
  | Ge AlexPosn
  | And AlexPosn
  | Or AlexPosn
  | Assign AlexPosn
  --
  | StrLiteral (AlexPosn, String)
  | IntLiteral (AlexPosn, Integer)
  | Id (AlexPosn, String)
  | Eof AlexPosn
  deriving (Eq, Show)

unquot (x:xs) = init xs
}
