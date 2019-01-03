module Absyn where

import           Lexer

-- data Pos = Pos { line :: Int, column :: Int }
--   deriving (Show, Eq)

type Symbol = String

data Var = SimpleVar Symbol Pos
         | FieldVar Var Symbol Pos
         | SubscriptVar Var Exp Pos
         deriving (Show, Eq)

data Exp = VarExp Var
         | NilExp
         | IntExp Integer
         | StringExp String Pos
         | CallExp { func :: Symbol, args:: [Exp], pos :: Pos }
         | OpExp { left :: Exp, oper :: Oper, right :: Exp, pos :: Pos}
         | RecordExp { fields :: [(Symbol, Exp, Pos)], record_typ :: Symbol, pos :: Pos }
         | SeqExp [(Exp, Pos)]
         | AssignExp { assign_var :: Var, exp :: Exp, pos :: Pos }
         | IfExp { test :: Exp, then' :: Exp, else' :: Maybe Exp, pos :: Pos }
         | WhileExp { test :: Exp, while_body :: Exp, pos :: Pos }
         | ForExp { for_var :: Symbol, escape :: Bool
                  , lo :: Exp, hi :: Exp, for_body :: Exp, pos :: Pos }
         | BreakExp Pos
         | LetExp { decs :: [Dec], body :: Exp, pos :: Pos }
         | ArrayExp { typ :: Symbol, size :: Exp, array_init :: Exp, pos :: Pos }
         deriving (Show, Eq)

data Dec = FunctionDec [FunDec]
         | VarDec { name :: Symbol, vardec_escape :: Bool
                  , vardec_typ :: Maybe (Symbol, Pos), vardec_init :: Exp, vardec_pos :: Pos }
         | TypeDec [(Symbol, Ty, Pos)]
         deriving (Show, Eq)

data Ty = NameTy Symbol Pos
        | RecordTy [Field]
        | ArrayTy Symbol Pos
        deriving (Show, Eq)

data Oper = PlusOp | MinusOp | TimesOp | DivideOp
          | EqOp | NeqOp | LtOp | LeOp | GtOp | GeOp
          deriving (Show, Eq)

data Field = Field { field_name :: Symbol, field_escape :: Bool
                   , field_typ :: Symbol, field_pos :: Pos }
           deriving (Show, Eq)

data FunDec = FunDec { fundec_name :: Symbol, params :: [Field]
                     , result :: Maybe (Symbol, Pos), fundec_body :: Exp, fundec_pos :: Pos }
            deriving (Eq, Show)
