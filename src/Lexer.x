{
module Lexer where

}

%wrapper "posn"

$digit = [0-9]
$lower = [a-z]
$alpha = [a-zA-z]
@ident = $lower [$alpha $digit]*

tokens :-

while {\p s -> While p}
{

data Token =
  While AlexPosn
}
