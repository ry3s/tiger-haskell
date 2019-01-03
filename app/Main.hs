module Main where

import           System.Environment

import           Lexer
import qualified Parser

main :: IO ()
main = do
  loop
  where
    loop = do
      s <- getLine
      if s == ""
        then return ()
        else do
        case Parser.parse $ alexScanTokens s of
          Right s -> do
            print $ show $ s
            loop
          Left e -> do
            print e
            loop
