module Semant where

import qualified Absyn
import qualified Absyn  as A
import qualified Env
import qualified Symbol
import qualified Types
import qualified Types  as T

type VEnv = Symbol.Table Env.EnvEntry
type TEnv = Symbol.Table Types.Ty

data ExpTy = ExpTy { ty :: Types.Ty }
           deriving (Show)
data Optype = Arith | Comp | Eq
            deriving (Eq, Show)

actualType ty pos = case ty of
  T.NAME s t -> case t of
    Just ty' -> actualType ty' pos
    Nothing  -> error $ show pos ++ "type error (actualType): " ++ s
  T.ARRAY ty' u -> T.ARRAY (actualType ty' pos) u
  _ -> ty

checkType t1 t2 pos = undefined

transExp :: VEnv -> TEnv -> Absyn.Exp -> ExpTy
transExp venv tenv = trExp
  where
    trExp :: Absyn.Exp -> ExpTy
    trExp A.NilExp          = ExpTy T.NIL
    trExp (A.IntExp _)      = ExpTy T.INT
    trExp (A.StringExp _ _) = ExpTy T.STRING
    trExp A.OpExp{A.left = lexp, A.oper = oper, A.right = rexp, A.pos = pos} =
      let
        ExpTy { ty = lty } = trExp lexp
        ExpTy { ty = rty } = trExp rexp

        classify op = case op of
          A.PlusOp   -> Arith
          A.MinusOp  -> Arith
          A.TimesOp  -> Arith
          A.DivideOp -> Arith
          A.LtOp     -> Comp
          A.GtOp     -> Comp
          A.LeOp     -> Comp
          A.GeOp     -> Comp
          A.EqOp     -> Eq
          A.NeqOp    -> Eq

        checkInt ty pos = case ty of
          T.INT -> True
          _     -> error $ show pos ++ ": integer required."

        checkArith = checkInt lty pos && checkInt rty pos

        checkEq = case lty of
          T.INT -> checkType lty rty pos
          T.STRING -> checkType lty rty pos
          T.ARRAY _ _ -> checkType lty rty pos
          T.NIL -> checkType lty rty pos
          _ -> error $ show pos ++ "type error(equal): " ++ show lty

        checkComp = case lty of
          T.INT    -> checkType lty rty pos
          T.STRING -> checkType lty rty pos
          _        -> error $ show pos ++ "type error(compare): " ++ show lty

        checkResult = case classify oper of
          Arith -> checkArith
          Comp  -> checkComp
          Eq    -> checkEq
      in
        if checkResult
        then ExpTy { ty = T.INT }
        else error "must not reach here."

    trExp (A.VarExp var) = trVar var

    trExp A.RecordExp {A.fields = fields, A.record_typ = typ, A.pos = pos} =
      case Symbol.lookup tenv typ of
        Nothing -> error $ show pos ++ "record type not found: " ++ show typ
        Just ty -> case actualType ty pos of
          T.RECORD fieldtys u ->
            let
              fieldexp = fmap (\(_, e, pos) -> (trExp e, pos)) fields
            in
              if checkRecord fieldtys fieldexp pos
              then ExpTy { ty = T.RECORD fieldtys u}
              else error $ show pos ++ "must not reach here"
      where
        checkRecord fieldtys fieldexp pos =
          let
            checker ((_, t1), (ExpTy{ty=t2}, pos')) = checkType t1 t2 pos'
            fs = zip fieldtys fieldexp
          in
            (length fieldtys == length fieldexp) && (and $ fmap checker fs)

    trExp (A.SeqExp exps) =
      let
        es = fmap trExp exps
        ty = if null exps
             then T.UNIT
             else case last es of ExpTy { ty = ty' } -> ty'
      in
        ExpTy { ty = ty }

    trExp A.AssignExp { A.var}
    trVar :: Absyn.Var -> ExpTy
    trVar = undefined


transDec :: VEnv -> TEnv -> Absyn.Dec -> (VEnv, TEnv)
transDec = undefined

transTy :: TEnv -> Absyn.Ty -> Types.Ty
transTy = undefined
