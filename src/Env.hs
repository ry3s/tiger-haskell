module Env where

import qualified Data.Map.Strict as Map

import qualified Symbol
import qualified Types

type Access = ()
type Ty = Types.Ty

data EnvEntry = VarEntry { ty :: Ty }
              | FunEntry { formals :: [Ty], result :: Ty }
              deriving (Eq, Show)

baseTEnv :: Symbol.Table Types.Ty
baseTEnv = Map.fromList [("int", Types.INT), ("string", Types.STRING)]

baseVEnv :: Symbol.Table EnvEntry
baseVEnv = Map.fromList xs
  where
    xs = [ ("print", FunEntry [Types.STRING] Types.UNIT)
         , ("flush", FunEntry [] Types.UNIT)
         , ("getchar", FunEntry [] Types.STRING)
         , ("ord", FunEntry [Types.STRING] Types.INT)
         , ("chr", FunEntry [Types.INT] Types.STRING)
         , ("size", FunEntry [Types.STRING] Types.INT)
         , ("substring", FunEntry [Types.STRING, Types.INT, Types.INT] Types.INT)
         , ("concat", FunEntry [Types.STRING, Types.STRING] Types.STRING)
         , ("not", FunEntry [Types.INT] Types.INT)
         , ("exit", FunEntry [Types.INT] Types.UNIT)
         ]
