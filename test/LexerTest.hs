module LexerTest where

import           Test.HUnit

import           Lexer

lexerTest :: Test
lexerTest = TestList
  ["Lexer test 1" ~:
    alexScanTokens "while for to break let in end function var type array if then else do of nil" ~?=
    [While _ , For _ , To _ , Break _ , Let _, In _, End _, Function _, Var _, Type _
    ,Array _, If _ , Then _, Else _, Do _, Of _, Nil _ ]
  ]
