{
module Lexer where

}

%wrapper "monadUserState"

$digit = [0-9]
$lower = [a-z]
$alpha = [a-zA-z]
@ident = $lower [$alpha $digit]*

{

}
