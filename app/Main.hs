module Main where

import           System.Environment

import           Lexer

main :: IO ()
main = do
  loop
  where
    loop = do
      s <- getLine
      if s == ""
        then return ()
        else do
        print $ show $ alexScanTokens s
        loop
