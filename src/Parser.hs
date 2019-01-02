{-# OPTIONS_GHC -w #-}
module Parser where

import Lexer
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29 t30 t31 t32 t33 t34
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26
	| HappyAbsSyn27 t27
	| HappyAbsSyn28 t28
	| HappyAbsSyn29 t29
	| HappyAbsSyn30 t30
	| HappyAbsSyn31 t31
	| HappyAbsSyn32 t32
	| HappyAbsSyn33 t33
	| HappyAbsSyn34 t34

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,600) ([0,0,8204,0,4096,0,0,2051,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,4096,0,0,0,0,512,0,0,0,0,0,0,0,0,38912,31,0,49152,512,0,256,0,0,0,0,64,0,3072,32,0,16,0,0,16384,4,0,0,0,0,0,0,0,0,0,0,0,0,8204,0,4096,0,0,0,0,1024,0,0,1024,0,0,0,0,0,0,8,0,0,256,0,0,0,6144,4352,16,7,0,1536,1088,49156,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32816,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,96,0,0,0,0,24,0,0,0,0,6,0,0,0,32768,1,0,0,0,24576,0,0,0,0,6144,0,0,0,0,64,0,0,0,0,0,0,0,0,0,384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49152,512,0,256,0,32768,4097,257,112,0,0,0,0,0,0,0,0,0,0,0,0,5120,1,0,0,0,0,6,0,0,8204,0,4096,0,0,2051,0,1024,0,49152,512,0,256,0,0,0,68,0,0,0,0,2,0,0,0,0,32768,0,0,192,2,0,1,0,0,0,16384,0,0,8204,0,4096,0,0,0,1088,0,0,49152,512,0,256,0,0,256,0,0,0,0,0,0,2,0,0,64,0,0,0,192,2,0,1,0,0,17416,0,0,0,0,0,0,0,0,2051,0,1024,0,0,2048,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1536,1088,49156,1,0,384,272,28673,0,0,8204,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,8192,0,0,0,40960,3,0,0,0,0,0,0,1,0,0,8192,0,0,0,0,8,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32816,0,16384,0,0,0,0,4096,0,0,0,0,1024,0,0,0,0,256,0,12288,128,0,64,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,49152,512,0,256,0,12288,128,0,64,0,0,0,2,0,0,0,0,0,0,0,192,2,0,1,0,32816,0,16384,0,0,8204,0,4096,0,0,2051,0,1024,0,0,0,32,0,0,0,0,68,0,0,0,128,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,8204,0,4096,0,0,0,0,1024,0,49152,512,0,256,0,0,0,68,0,0,0,0,17,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,8204,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,4096,0,0,0,0,4096,0,0,0,4096,0,0,0,0,32816,0,16384,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,8192,0,0,0,0,16384,0,0,4096,1024,4096,0,0,0,0,0,0,49152,512,0,256,0,12288,128,0,64,0,0,64,0,0,0,0,0,32768,0,0,0,16,0,0,0,32816,0,16384,0,0,8204,0,4096,0,0,2051,0,1024,0,0,4096,0,0,0,12288,128,0,64,0,3072,32,0,16,0,768,8,0,4,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32816,0,16384,0,0,0,128,0,0,0,0,2,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,16,0,0,0,0,4,0,0,256,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,1024,0,0,8192,272,0,0,0,512,0,0,0,4096,0,0,0,0,768,8,0,4,0,192,2,0,1,0,32816,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,768,8,0,4,0,0,16,0,0,0,32816,0,16384,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Program","Decs","Dec","TyDec","Ty","TyFields","TyFieldsRev","TyField","TypeId","VarDec","OptType","FunDec","Expr","Matched","Unmatched","LValue","LValue1","Disjunction","Conjunction","Compare","ArithExpr","Term","PrefExpr","Factor","CallArgs","CallArgsRev","Fields","FieldsRev","Field","ExprSequence","ExprSequenceRev","while","for","to","break","let","in","end","function","var","type","array","if","then","else","do","of","nil","','","':'","';'","'('","')'","'['","']'","'{'","'}'","'.'","'+'","'-'","'*'","'/'","'='","'<>'","'<'","'<='","'>'","'>='","'&'","'|'","':='","string","int","id","%eof"]
        bit_start = st * 78
        bit_end = (st + 1) * 78
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..77]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (35) = happyShift action_10
action_0 (36) = happyShift action_11
action_0 (46) = happyShift action_12
action_0 (77) = happyShift action_13
action_0 (4) = happyGoto action_14
action_0 (16) = happyGoto action_2
action_0 (17) = happyGoto action_3
action_0 (18) = happyGoto action_4
action_0 (19) = happyGoto action_5
action_0 (21) = happyGoto action_6
action_0 (22) = happyGoto action_7
action_0 (23) = happyGoto action_8
action_0 (24) = happyGoto action_9
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (35) = happyShift action_10
action_1 (36) = happyShift action_11
action_1 (46) = happyShift action_12
action_1 (77) = happyShift action_13
action_1 (16) = happyGoto action_2
action_1 (17) = happyGoto action_3
action_1 (18) = happyGoto action_4
action_1 (19) = happyGoto action_5
action_1 (21) = happyGoto action_6
action_1 (22) = happyGoto action_7
action_1 (23) = happyGoto action_8
action_1 (24) = happyGoto action_9
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 _ = happyReduce_21

action_4 _ = happyReduce_22

action_5 (74) = happyShift action_31
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (73) = happyShift action_30
action_6 _ = happyReduce_23

action_7 (72) = happyShift action_29
action_7 _ = happyReduce_40

action_8 _ = happyReduce_42

action_9 (62) = happyShift action_21
action_9 (63) = happyShift action_22
action_9 (66) = happyShift action_23
action_9 (67) = happyShift action_24
action_9 (68) = happyShift action_25
action_9 (69) = happyShift action_26
action_9 (70) = happyShift action_27
action_9 (71) = happyShift action_28
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (35) = happyShift action_10
action_10 (36) = happyShift action_11
action_10 (46) = happyShift action_12
action_10 (77) = happyShift action_13
action_10 (16) = happyGoto action_20
action_10 (17) = happyGoto action_3
action_10 (18) = happyGoto action_4
action_10 (19) = happyGoto action_5
action_10 (21) = happyGoto action_6
action_10 (22) = happyGoto action_7
action_10 (23) = happyGoto action_8
action_10 (24) = happyGoto action_9
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (77) = happyShift action_19
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (35) = happyShift action_10
action_12 (36) = happyShift action_11
action_12 (46) = happyShift action_12
action_12 (77) = happyShift action_13
action_12 (16) = happyGoto action_18
action_12 (17) = happyGoto action_3
action_12 (18) = happyGoto action_4
action_12 (19) = happyGoto action_5
action_12 (21) = happyGoto action_6
action_12 (22) = happyGoto action_7
action_12 (23) = happyGoto action_8
action_12 (24) = happyGoto action_9
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (57) = happyShift action_16
action_13 (61) = happyShift action_17
action_13 (20) = happyGoto action_15
action_13 _ = happyReduce_38

action_14 (78) = happyAccept
action_14 _ = happyFail (happyExpListPerState 14)

action_15 _ = happyReduce_35

action_16 (35) = happyShift action_62
action_16 (36) = happyShift action_63
action_16 (46) = happyShift action_64
action_16 (77) = happyShift action_65
action_16 (17) = happyGoto action_60
action_16 (19) = happyGoto action_61
action_16 (21) = happyGoto action_6
action_16 (22) = happyGoto action_7
action_16 (23) = happyGoto action_8
action_16 (24) = happyGoto action_9
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (77) = happyShift action_59
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (47) = happyShift action_58
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (74) = happyShift action_57
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (49) = happyShift action_56
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (38) = happyShift action_47
action_21 (39) = happyShift action_48
action_21 (51) = happyShift action_49
action_21 (55) = happyShift action_50
action_21 (63) = happyShift action_51
action_21 (75) = happyShift action_52
action_21 (76) = happyShift action_53
action_21 (77) = happyShift action_54
action_21 (12) = happyGoto action_42
action_21 (19) = happyGoto action_43
action_21 (25) = happyGoto action_55
action_21 (26) = happyGoto action_45
action_21 (27) = happyGoto action_46
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (38) = happyShift action_47
action_22 (39) = happyShift action_48
action_22 (51) = happyShift action_49
action_22 (55) = happyShift action_50
action_22 (63) = happyShift action_51
action_22 (75) = happyShift action_52
action_22 (76) = happyShift action_53
action_22 (77) = happyShift action_54
action_22 (12) = happyGoto action_42
action_22 (19) = happyGoto action_43
action_22 (25) = happyGoto action_44
action_22 (26) = happyGoto action_45
action_22 (27) = happyGoto action_46
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (24) = happyGoto action_41
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (24) = happyGoto action_40
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (24) = happyGoto action_39
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (24) = happyGoto action_38
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (24) = happyGoto action_37
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (24) = happyGoto action_36
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (23) = happyGoto action_35
action_29 (24) = happyGoto action_9
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (22) = happyGoto action_34
action_30 (23) = happyGoto action_8
action_30 (24) = happyGoto action_9
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (35) = happyShift action_10
action_31 (36) = happyShift action_11
action_31 (46) = happyShift action_12
action_31 (77) = happyShift action_13
action_31 (17) = happyGoto action_32
action_31 (18) = happyGoto action_33
action_31 (19) = happyGoto action_5
action_31 (21) = happyGoto action_6
action_31 (22) = happyGoto action_7
action_31 (23) = happyGoto action_8
action_31 (24) = happyGoto action_9
action_31 _ = happyFail (happyExpListPerState 31)

action_32 _ = happyReduce_24

action_33 _ = happyReduce_29

action_34 (72) = happyShift action_29
action_34 _ = happyReduce_39

action_35 _ = happyReduce_41

action_36 (62) = happyShift action_21
action_36 (63) = happyShift action_22
action_36 _ = happyReduce_47

action_37 (62) = happyShift action_21
action_37 (63) = happyShift action_22
action_37 _ = happyReduce_45

action_38 (62) = happyShift action_21
action_38 (63) = happyShift action_22
action_38 _ = happyReduce_48

action_39 (62) = happyShift action_21
action_39 (63) = happyShift action_22
action_39 _ = happyReduce_46

action_40 (62) = happyShift action_21
action_40 (63) = happyShift action_22
action_40 _ = happyReduce_44

action_41 (62) = happyShift action_21
action_41 (63) = happyShift action_22
action_41 _ = happyReduce_43

action_42 (59) = happyShift action_86
action_42 _ = happyFail (happyExpListPerState 42)

action_43 _ = happyReduce_56

action_44 (64) = happyShift action_78
action_44 (65) = happyShift action_79
action_44 _ = happyReduce_50

action_45 _ = happyReduce_53

action_46 _ = happyReduce_55

action_47 _ = happyReduce_63

action_48 (5) = happyGoto action_85
action_48 _ = happyReduce_3

action_49 _ = happyReduce_57

action_50 (35) = happyShift action_10
action_50 (36) = happyShift action_11
action_50 (46) = happyShift action_12
action_50 (77) = happyShift action_13
action_50 (16) = happyGoto action_82
action_50 (17) = happyGoto action_3
action_50 (18) = happyGoto action_4
action_50 (19) = happyGoto action_5
action_50 (21) = happyGoto action_6
action_50 (22) = happyGoto action_7
action_50 (23) = happyGoto action_8
action_50 (24) = happyGoto action_9
action_50 (33) = happyGoto action_83
action_50 (34) = happyGoto action_84
action_50 _ = happyReduce_75

action_51 (38) = happyShift action_47
action_51 (39) = happyShift action_48
action_51 (51) = happyShift action_49
action_51 (55) = happyShift action_50
action_51 (63) = happyShift action_51
action_51 (75) = happyShift action_52
action_51 (76) = happyShift action_53
action_51 (77) = happyShift action_54
action_51 (12) = happyGoto action_42
action_51 (19) = happyGoto action_43
action_51 (26) = happyGoto action_81
action_51 (27) = happyGoto action_46
action_51 _ = happyFail (happyExpListPerState 51)

action_52 _ = happyReduce_60

action_53 _ = happyReduce_59

action_54 (55) = happyShift action_80
action_54 (57) = happyShift action_73
action_54 (59) = happyReduce_16
action_54 (61) = happyShift action_17
action_54 (20) = happyGoto action_15
action_54 _ = happyReduce_38

action_55 (64) = happyShift action_78
action_55 (65) = happyShift action_79
action_55 _ = happyReduce_49

action_56 (35) = happyShift action_10
action_56 (36) = happyShift action_11
action_56 (46) = happyShift action_12
action_56 (77) = happyShift action_13
action_56 (17) = happyGoto action_76
action_56 (18) = happyGoto action_77
action_56 (19) = happyGoto action_5
action_56 (21) = happyGoto action_6
action_56 (22) = happyGoto action_7
action_56 (23) = happyGoto action_8
action_56 (24) = happyGoto action_9
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (35) = happyShift action_10
action_57 (36) = happyShift action_11
action_57 (46) = happyShift action_12
action_57 (77) = happyShift action_13
action_57 (16) = happyGoto action_75
action_57 (17) = happyGoto action_3
action_57 (18) = happyGoto action_4
action_57 (19) = happyGoto action_5
action_57 (21) = happyGoto action_6
action_57 (22) = happyGoto action_7
action_57 (23) = happyGoto action_8
action_57 (24) = happyGoto action_9
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (35) = happyShift action_62
action_58 (36) = happyShift action_63
action_58 (46) = happyShift action_64
action_58 (77) = happyShift action_65
action_58 (17) = happyGoto action_74
action_58 (19) = happyGoto action_61
action_58 (21) = happyGoto action_6
action_58 (22) = happyGoto action_7
action_58 (23) = happyGoto action_8
action_58 (24) = happyGoto action_9
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (57) = happyShift action_73
action_59 (61) = happyShift action_17
action_59 (20) = happyGoto action_72
action_59 _ = happyReduce_38

action_60 (58) = happyShift action_71
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (74) = happyShift action_70
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (35) = happyShift action_10
action_62 (36) = happyShift action_11
action_62 (46) = happyShift action_12
action_62 (77) = happyShift action_13
action_62 (16) = happyGoto action_69
action_62 (17) = happyGoto action_3
action_62 (18) = happyGoto action_4
action_62 (19) = happyGoto action_5
action_62 (21) = happyGoto action_6
action_62 (22) = happyGoto action_7
action_62 (23) = happyGoto action_8
action_62 (24) = happyGoto action_9
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (77) = happyShift action_68
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (35) = happyShift action_10
action_64 (36) = happyShift action_11
action_64 (46) = happyShift action_12
action_64 (77) = happyShift action_13
action_64 (16) = happyGoto action_67
action_64 (17) = happyGoto action_3
action_64 (18) = happyGoto action_4
action_64 (19) = happyGoto action_5
action_64 (21) = happyGoto action_6
action_64 (22) = happyGoto action_7
action_64 (23) = happyGoto action_8
action_64 (24) = happyGoto action_9
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (57) = happyShift action_66
action_65 (61) = happyShift action_17
action_65 (20) = happyGoto action_15
action_65 _ = happyReduce_38

action_66 (35) = happyShift action_62
action_66 (36) = happyShift action_63
action_66 (46) = happyShift action_64
action_66 (77) = happyShift action_65
action_66 (17) = happyGoto action_114
action_66 (19) = happyGoto action_61
action_66 (21) = happyGoto action_6
action_66 (22) = happyGoto action_7
action_66 (23) = happyGoto action_8
action_66 (24) = happyGoto action_9
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (47) = happyShift action_113
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (74) = happyShift action_112
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (49) = happyShift action_111
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (35) = happyShift action_62
action_70 (36) = happyShift action_63
action_70 (46) = happyShift action_64
action_70 (77) = happyShift action_65
action_70 (17) = happyGoto action_32
action_70 (19) = happyGoto action_61
action_70 (21) = happyGoto action_6
action_70 (22) = happyGoto action_7
action_70 (23) = happyGoto action_8
action_70 (24) = happyGoto action_9
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (50) = happyShift action_110
action_71 (57) = happyShift action_73
action_71 (61) = happyShift action_17
action_71 (74) = happyReduce_38
action_71 (20) = happyGoto action_109
action_71 _ = happyReduce_25

action_72 _ = happyReduce_37

action_73 (35) = happyShift action_62
action_73 (36) = happyShift action_63
action_73 (46) = happyShift action_64
action_73 (77) = happyShift action_65
action_73 (17) = happyGoto action_108
action_73 (19) = happyGoto action_61
action_73 (21) = happyGoto action_6
action_73 (22) = happyGoto action_7
action_73 (23) = happyGoto action_8
action_73 (24) = happyGoto action_9
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (48) = happyShift action_107
action_74 _ = happyReduce_32

action_75 (37) = happyShift action_106
action_75 _ = happyFail (happyExpListPerState 75)

action_76 _ = happyReduce_27

action_77 _ = happyReduce_33

action_78 (38) = happyShift action_47
action_78 (39) = happyShift action_48
action_78 (51) = happyShift action_49
action_78 (55) = happyShift action_50
action_78 (63) = happyShift action_51
action_78 (75) = happyShift action_52
action_78 (76) = happyShift action_53
action_78 (77) = happyShift action_54
action_78 (12) = happyGoto action_42
action_78 (19) = happyGoto action_43
action_78 (26) = happyGoto action_105
action_78 (27) = happyGoto action_46
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (38) = happyShift action_47
action_79 (39) = happyShift action_48
action_79 (51) = happyShift action_49
action_79 (55) = happyShift action_50
action_79 (63) = happyShift action_51
action_79 (75) = happyShift action_52
action_79 (76) = happyShift action_53
action_79 (77) = happyShift action_54
action_79 (12) = happyGoto action_42
action_79 (19) = happyGoto action_43
action_79 (26) = happyGoto action_104
action_79 (27) = happyGoto action_46
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (35) = happyShift action_10
action_80 (36) = happyShift action_11
action_80 (46) = happyShift action_12
action_80 (77) = happyShift action_13
action_80 (16) = happyGoto action_101
action_80 (17) = happyGoto action_3
action_80 (18) = happyGoto action_4
action_80 (19) = happyGoto action_5
action_80 (21) = happyGoto action_6
action_80 (22) = happyGoto action_7
action_80 (23) = happyGoto action_8
action_80 (24) = happyGoto action_9
action_80 (28) = happyGoto action_102
action_80 (29) = happyGoto action_103
action_80 _ = happyReduce_66

action_81 _ = happyReduce_54

action_82 _ = happyReduce_76

action_83 (56) = happyShift action_100
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (54) = happyShift action_99
action_84 _ = happyReduce_74

action_85 (40) = happyShift action_95
action_85 (42) = happyShift action_96
action_85 (43) = happyShift action_97
action_85 (44) = happyShift action_98
action_85 (6) = happyGoto action_91
action_85 (7) = happyGoto action_92
action_85 (13) = happyGoto action_93
action_85 (15) = happyGoto action_94
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (77) = happyShift action_90
action_86 (30) = happyGoto action_87
action_86 (31) = happyGoto action_88
action_86 (32) = happyGoto action_89
action_86 _ = happyReduce_70

action_87 (60) = happyShift action_137
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (52) = happyShift action_136
action_88 _ = happyReduce_69

action_89 _ = happyReduce_71

action_90 (66) = happyShift action_135
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_2

action_92 _ = happyReduce_4

action_93 _ = happyReduce_5

action_94 _ = happyReduce_6

action_95 (35) = happyShift action_10
action_95 (36) = happyShift action_11
action_95 (46) = happyShift action_12
action_95 (77) = happyShift action_13
action_95 (16) = happyGoto action_82
action_95 (17) = happyGoto action_3
action_95 (18) = happyGoto action_4
action_95 (19) = happyGoto action_5
action_95 (21) = happyGoto action_6
action_95 (22) = happyGoto action_7
action_95 (23) = happyGoto action_8
action_95 (24) = happyGoto action_9
action_95 (33) = happyGoto action_134
action_95 (34) = happyGoto action_84
action_95 _ = happyReduce_75

action_96 (77) = happyShift action_133
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (77) = happyShift action_132
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (77) = happyShift action_131
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (35) = happyShift action_10
action_99 (36) = happyShift action_11
action_99 (46) = happyShift action_12
action_99 (77) = happyShift action_13
action_99 (16) = happyGoto action_130
action_99 (17) = happyGoto action_3
action_99 (18) = happyGoto action_4
action_99 (19) = happyGoto action_5
action_99 (21) = happyGoto action_6
action_99 (22) = happyGoto action_7
action_99 (23) = happyGoto action_8
action_99 (24) = happyGoto action_9
action_99 _ = happyFail (happyExpListPerState 99)

action_100 _ = happyReduce_58

action_101 _ = happyReduce_67

action_102 (56) = happyShift action_129
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (52) = happyShift action_128
action_103 _ = happyReduce_65

action_104 _ = happyReduce_52

action_105 _ = happyReduce_51

action_106 (35) = happyShift action_10
action_106 (36) = happyShift action_11
action_106 (46) = happyShift action_12
action_106 (77) = happyShift action_13
action_106 (16) = happyGoto action_127
action_106 (17) = happyGoto action_3
action_106 (18) = happyGoto action_4
action_106 (19) = happyGoto action_5
action_106 (21) = happyGoto action_6
action_106 (22) = happyGoto action_7
action_106 (23) = happyGoto action_8
action_106 (24) = happyGoto action_9
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (35) = happyShift action_10
action_107 (36) = happyShift action_11
action_107 (46) = happyShift action_12
action_107 (77) = happyShift action_13
action_107 (17) = happyGoto action_125
action_107 (18) = happyGoto action_126
action_107 (19) = happyGoto action_5
action_107 (21) = happyGoto action_6
action_107 (22) = happyGoto action_7
action_107 (23) = happyGoto action_8
action_107 (24) = happyGoto action_9
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (58) = happyShift action_124
action_108 _ = happyFail (happyExpListPerState 108)

action_109 _ = happyReduce_36

action_110 (35) = happyShift action_120
action_110 (36) = happyShift action_121
action_110 (46) = happyShift action_122
action_110 (77) = happyShift action_123
action_110 (18) = happyGoto action_118
action_110 (19) = happyGoto action_119
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (35) = happyShift action_62
action_111 (36) = happyShift action_63
action_111 (46) = happyShift action_64
action_111 (77) = happyShift action_65
action_111 (17) = happyGoto action_76
action_111 (19) = happyGoto action_61
action_111 (21) = happyGoto action_6
action_111 (22) = happyGoto action_7
action_111 (23) = happyGoto action_8
action_111 (24) = happyGoto action_9
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (35) = happyShift action_10
action_112 (36) = happyShift action_11
action_112 (46) = happyShift action_12
action_112 (77) = happyShift action_13
action_112 (16) = happyGoto action_117
action_112 (17) = happyGoto action_3
action_112 (18) = happyGoto action_4
action_112 (19) = happyGoto action_5
action_112 (21) = happyGoto action_6
action_112 (22) = happyGoto action_7
action_112 (23) = happyGoto action_8
action_112 (24) = happyGoto action_9
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (35) = happyShift action_62
action_113 (36) = happyShift action_63
action_113 (46) = happyShift action_64
action_113 (77) = happyShift action_65
action_113 (17) = happyGoto action_116
action_113 (19) = happyGoto action_61
action_113 (21) = happyGoto action_6
action_113 (22) = happyGoto action_7
action_113 (23) = happyGoto action_8
action_113 (24) = happyGoto action_9
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (58) = happyShift action_115
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (57) = happyShift action_73
action_115 (61) = happyShift action_17
action_115 (74) = happyReduce_38
action_115 (20) = happyGoto action_109
action_115 _ = happyReduce_25

action_116 (48) = happyShift action_153
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (37) = happyShift action_152
action_117 _ = happyFail (happyExpListPerState 117)

action_118 _ = happyReduce_30

action_119 (74) = happyShift action_151
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (35) = happyShift action_10
action_120 (36) = happyShift action_11
action_120 (46) = happyShift action_12
action_120 (77) = happyShift action_13
action_120 (16) = happyGoto action_150
action_120 (17) = happyGoto action_3
action_120 (18) = happyGoto action_4
action_120 (19) = happyGoto action_5
action_120 (21) = happyGoto action_6
action_120 (22) = happyGoto action_7
action_120 (23) = happyGoto action_8
action_120 (24) = happyGoto action_9
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (77) = happyShift action_149
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (35) = happyShift action_10
action_122 (36) = happyShift action_11
action_122 (46) = happyShift action_12
action_122 (77) = happyShift action_13
action_122 (16) = happyGoto action_148
action_122 (17) = happyGoto action_3
action_122 (18) = happyGoto action_4
action_122 (19) = happyGoto action_5
action_122 (21) = happyGoto action_6
action_122 (22) = happyGoto action_7
action_122 (23) = happyGoto action_8
action_122 (24) = happyGoto action_9
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (57) = happyShift action_147
action_123 (61) = happyShift action_17
action_123 (20) = happyGoto action_15
action_123 _ = happyReduce_38

action_124 (57) = happyShift action_73
action_124 (61) = happyShift action_17
action_124 (20) = happyGoto action_109
action_124 _ = happyReduce_38

action_125 _ = happyReduce_26

action_126 _ = happyReduce_31

action_127 (49) = happyShift action_146
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (35) = happyShift action_10
action_128 (36) = happyShift action_11
action_128 (46) = happyShift action_12
action_128 (77) = happyShift action_13
action_128 (16) = happyGoto action_145
action_128 (17) = happyGoto action_3
action_128 (18) = happyGoto action_4
action_128 (19) = happyGoto action_5
action_128 (21) = happyGoto action_6
action_128 (22) = happyGoto action_7
action_128 (23) = happyGoto action_8
action_128 (24) = happyGoto action_9
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_61

action_130 _ = happyReduce_77

action_131 (66) = happyShift action_144
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (53) = happyShift action_143
action_132 (14) = happyGoto action_142
action_132 _ = happyReduce_19

action_133 (55) = happyShift action_141
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (41) = happyShift action_140
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (35) = happyShift action_10
action_135 (36) = happyShift action_11
action_135 (46) = happyShift action_12
action_135 (77) = happyShift action_13
action_135 (16) = happyGoto action_139
action_135 (17) = happyGoto action_3
action_135 (18) = happyGoto action_4
action_135 (19) = happyGoto action_5
action_135 (21) = happyGoto action_6
action_135 (22) = happyGoto action_7
action_135 (23) = happyGoto action_8
action_135 (24) = happyGoto action_9
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (77) = happyShift action_90
action_136 (32) = happyGoto action_138
action_136 _ = happyFail (happyExpListPerState 136)

action_137 _ = happyReduce_62

action_138 _ = happyReduce_72

action_139 _ = happyReduce_73

action_140 _ = happyReduce_64

action_141 (77) = happyShift action_171
action_141 (9) = happyGoto action_168
action_141 (10) = happyGoto action_169
action_141 (11) = happyGoto action_170
action_141 _ = happyReduce_12

action_142 (74) = happyShift action_167
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (77) = happyShift action_166
action_143 (12) = happyGoto action_165
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (45) = happyShift action_162
action_144 (59) = happyShift action_163
action_144 (77) = happyShift action_164
action_144 (8) = happyGoto action_161
action_144 _ = happyFail (happyExpListPerState 144)

action_145 _ = happyReduce_68

action_146 (35) = happyShift action_10
action_146 (36) = happyShift action_11
action_146 (46) = happyShift action_12
action_146 (77) = happyShift action_13
action_146 (17) = happyGoto action_159
action_146 (18) = happyGoto action_160
action_146 (19) = happyGoto action_5
action_146 (21) = happyGoto action_6
action_146 (22) = happyGoto action_7
action_146 (23) = happyGoto action_8
action_146 (24) = happyGoto action_9
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (35) = happyShift action_62
action_147 (36) = happyShift action_63
action_147 (46) = happyShift action_64
action_147 (77) = happyShift action_65
action_147 (17) = happyGoto action_158
action_147 (19) = happyGoto action_61
action_147 (21) = happyGoto action_6
action_147 (22) = happyGoto action_7
action_147 (23) = happyGoto action_8
action_147 (24) = happyGoto action_9
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (47) = happyShift action_157
action_148 _ = happyFail (happyExpListPerState 148)

action_149 (74) = happyShift action_156
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (49) = happyShift action_155
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (35) = happyShift action_120
action_151 (36) = happyShift action_121
action_151 (46) = happyShift action_122
action_151 (77) = happyShift action_123
action_151 (18) = happyGoto action_33
action_151 (19) = happyGoto action_119
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (35) = happyShift action_10
action_152 (36) = happyShift action_11
action_152 (46) = happyShift action_12
action_152 (77) = happyShift action_13
action_152 (16) = happyGoto action_154
action_152 (17) = happyGoto action_3
action_152 (18) = happyGoto action_4
action_152 (19) = happyGoto action_5
action_152 (21) = happyGoto action_6
action_152 (22) = happyGoto action_7
action_152 (23) = happyGoto action_8
action_152 (24) = happyGoto action_9
action_152 _ = happyFail (happyExpListPerState 152)

action_153 (35) = happyShift action_62
action_153 (36) = happyShift action_63
action_153 (46) = happyShift action_64
action_153 (77) = happyShift action_65
action_153 (17) = happyGoto action_125
action_153 (19) = happyGoto action_61
action_153 (21) = happyGoto action_6
action_153 (22) = happyGoto action_7
action_153 (23) = happyGoto action_8
action_153 (24) = happyGoto action_9
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (49) = happyShift action_181
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (35) = happyShift action_120
action_155 (36) = happyShift action_121
action_155 (46) = happyShift action_122
action_155 (77) = happyShift action_123
action_155 (18) = happyGoto action_77
action_155 (19) = happyGoto action_119
action_155 _ = happyFail (happyExpListPerState 155)

action_156 (35) = happyShift action_10
action_156 (36) = happyShift action_11
action_156 (46) = happyShift action_12
action_156 (77) = happyShift action_13
action_156 (16) = happyGoto action_180
action_156 (17) = happyGoto action_3
action_156 (18) = happyGoto action_4
action_156 (19) = happyGoto action_5
action_156 (21) = happyGoto action_6
action_156 (22) = happyGoto action_7
action_156 (23) = happyGoto action_8
action_156 (24) = happyGoto action_9
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (35) = happyShift action_62
action_157 (36) = happyShift action_63
action_157 (46) = happyShift action_64
action_157 (77) = happyShift action_65
action_157 (17) = happyGoto action_179
action_157 (19) = happyGoto action_61
action_157 (21) = happyGoto action_6
action_157 (22) = happyGoto action_7
action_157 (23) = happyGoto action_8
action_157 (24) = happyGoto action_9
action_157 _ = happyFail (happyExpListPerState 157)

action_158 (58) = happyShift action_178
action_158 _ = happyFail (happyExpListPerState 158)

action_159 _ = happyReduce_28

action_160 _ = happyReduce_34

action_161 _ = happyReduce_7

action_162 (50) = happyShift action_177
action_162 _ = happyFail (happyExpListPerState 162)

action_163 (77) = happyShift action_171
action_163 (9) = happyGoto action_176
action_163 (10) = happyGoto action_169
action_163 (11) = happyGoto action_170
action_163 _ = happyReduce_12

action_164 _ = happyReduce_8

action_165 _ = happyReduce_18

action_166 _ = happyReduce_16

action_167 (35) = happyShift action_10
action_167 (36) = happyShift action_11
action_167 (46) = happyShift action_12
action_167 (77) = happyShift action_13
action_167 (16) = happyGoto action_175
action_167 (17) = happyGoto action_3
action_167 (18) = happyGoto action_4
action_167 (19) = happyGoto action_5
action_167 (21) = happyGoto action_6
action_167 (22) = happyGoto action_7
action_167 (23) = happyGoto action_8
action_167 (24) = happyGoto action_9
action_167 _ = happyFail (happyExpListPerState 167)

action_168 (56) = happyShift action_174
action_168 _ = happyFail (happyExpListPerState 168)

action_169 (52) = happyShift action_173
action_169 _ = happyReduce_11

action_170 _ = happyReduce_13

action_171 (53) = happyShift action_172
action_171 _ = happyFail (happyExpListPerState 171)

action_172 (77) = happyShift action_166
action_172 (12) = happyGoto action_188
action_172 _ = happyFail (happyExpListPerState 172)

action_173 (77) = happyShift action_171
action_173 (11) = happyGoto action_187
action_173 _ = happyFail (happyExpListPerState 173)

action_174 (53) = happyShift action_143
action_174 (14) = happyGoto action_186
action_174 _ = happyReduce_19

action_175 _ = happyReduce_17

action_176 (60) = happyShift action_185
action_176 _ = happyFail (happyExpListPerState 176)

action_177 (77) = happyShift action_184
action_177 _ = happyFail (happyExpListPerState 177)

action_178 (50) = happyShift action_110
action_178 (57) = happyShift action_73
action_178 (61) = happyShift action_17
action_178 (20) = happyGoto action_109
action_178 _ = happyReduce_38

action_179 (48) = happyShift action_183
action_179 _ = happyReduce_32

action_180 (37) = happyShift action_182
action_180 _ = happyFail (happyExpListPerState 180)

action_181 (35) = happyShift action_62
action_181 (36) = happyShift action_63
action_181 (46) = happyShift action_64
action_181 (77) = happyShift action_65
action_181 (17) = happyGoto action_159
action_181 (19) = happyGoto action_61
action_181 (21) = happyGoto action_6
action_181 (22) = happyGoto action_7
action_181 (23) = happyGoto action_8
action_181 (24) = happyGoto action_9
action_181 _ = happyFail (happyExpListPerState 181)

action_182 (35) = happyShift action_10
action_182 (36) = happyShift action_11
action_182 (46) = happyShift action_12
action_182 (77) = happyShift action_13
action_182 (16) = happyGoto action_190
action_182 (17) = happyGoto action_3
action_182 (18) = happyGoto action_4
action_182 (19) = happyGoto action_5
action_182 (21) = happyGoto action_6
action_182 (22) = happyGoto action_7
action_182 (23) = happyGoto action_8
action_182 (24) = happyGoto action_9
action_182 _ = happyFail (happyExpListPerState 182)

action_183 (35) = happyShift action_120
action_183 (36) = happyShift action_121
action_183 (46) = happyShift action_122
action_183 (77) = happyShift action_123
action_183 (18) = happyGoto action_126
action_183 (19) = happyGoto action_119
action_183 _ = happyFail (happyExpListPerState 183)

action_184 _ = happyReduce_10

action_185 _ = happyReduce_9

action_186 (66) = happyShift action_189
action_186 _ = happyFail (happyExpListPerState 186)

action_187 _ = happyReduce_14

action_188 _ = happyReduce_15

action_189 (35) = happyShift action_10
action_189 (36) = happyShift action_11
action_189 (46) = happyShift action_12
action_189 (77) = happyShift action_13
action_189 (16) = happyGoto action_192
action_189 (17) = happyGoto action_3
action_189 (18) = happyGoto action_4
action_189 (19) = happyGoto action_5
action_189 (21) = happyGoto action_6
action_189 (22) = happyGoto action_7
action_189 (23) = happyGoto action_8
action_189 (24) = happyGoto action_9
action_189 _ = happyFail (happyExpListPerState 189)

action_190 (49) = happyShift action_191
action_190 _ = happyFail (happyExpListPerState 190)

action_191 (35) = happyShift action_120
action_191 (36) = happyShift action_121
action_191 (46) = happyShift action_122
action_191 (77) = happyShift action_123
action_191 (18) = happyGoto action_160
action_191 (19) = happyGoto action_119
action_191 _ = happyFail (happyExpListPerState 191)

action_192 _ = happyReduce_20

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 _
	 =  HappyAbsSyn4
		 (
	)

happyReduce_2 = happySpecReduce_2  5 happyReduction_2
happyReduction_2 _
	_
	 =  HappyAbsSyn5
		 (
	)

happyReduce_3 = happySpecReduce_0  5 happyReduction_3
happyReduction_3  =  HappyAbsSyn5
		 (
	)

happyReduce_4 = happySpecReduce_1  6 happyReduction_4
happyReduction_4 _
	 =  HappyAbsSyn6
		 (
	)

happyReduce_5 = happySpecReduce_1  6 happyReduction_5
happyReduction_5 _
	 =  HappyAbsSyn6
		 (
	)

happyReduce_6 = happySpecReduce_1  6 happyReduction_6
happyReduction_6 _
	 =  HappyAbsSyn6
		 (
	)

happyReduce_7 = happyReduce 4 7 happyReduction_7
happyReduction_7 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (
	) `HappyStk` happyRest

happyReduce_8 = happySpecReduce_1  8 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn8
		 (
	)

happyReduce_9 = happySpecReduce_3  8 happyReduction_9
happyReduction_9 _
	_
	_
	 =  HappyAbsSyn8
		 (
	)

happyReduce_10 = happySpecReduce_3  8 happyReduction_10
happyReduction_10 _
	_
	_
	 =  HappyAbsSyn8
		 (
	)

happyReduce_11 = happySpecReduce_1  9 happyReduction_11
happyReduction_11 _
	 =  HappyAbsSyn9
		 (
	)

happyReduce_12 = happySpecReduce_0  9 happyReduction_12
happyReduction_12  =  HappyAbsSyn9
		 (
	)

happyReduce_13 = happySpecReduce_1  10 happyReduction_13
happyReduction_13 _
	 =  HappyAbsSyn10
		 (
	)

happyReduce_14 = happySpecReduce_3  10 happyReduction_14
happyReduction_14 _
	_
	_
	 =  HappyAbsSyn10
		 (
	)

happyReduce_15 = happySpecReduce_3  11 happyReduction_15
happyReduction_15 _
	_
	_
	 =  HappyAbsSyn11
		 (
	)

happyReduce_16 = happySpecReduce_1  12 happyReduction_16
happyReduction_16 _
	 =  HappyAbsSyn12
		 (
	)

happyReduce_17 = happyReduce 5 13 happyReduction_17
happyReduction_17 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (
	) `HappyStk` happyRest

happyReduce_18 = happySpecReduce_2  14 happyReduction_18
happyReduction_18 _
	_
	 =  HappyAbsSyn14
		 (
	)

happyReduce_19 = happySpecReduce_0  14 happyReduction_19
happyReduction_19  =  HappyAbsSyn14
		 (
	)

happyReduce_20 = happyReduce 8 15 happyReduction_20
happyReduction_20 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (
	) `HappyStk` happyRest

happyReduce_21 = happySpecReduce_1  16 happyReduction_21
happyReduction_21 _
	 =  HappyAbsSyn16
		 (
	)

happyReduce_22 = happySpecReduce_1  16 happyReduction_22
happyReduction_22 _
	 =  HappyAbsSyn16
		 (
	)

happyReduce_23 = happySpecReduce_1  17 happyReduction_23
happyReduction_23 _
	 =  HappyAbsSyn17
		 (
	)

happyReduce_24 = happySpecReduce_3  17 happyReduction_24
happyReduction_24 _
	_
	_
	 =  HappyAbsSyn17
		 (
	)

happyReduce_25 = happyReduce 4 17 happyReduction_25
happyReduction_25 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (
	) `HappyStk` happyRest

happyReduce_26 = happyReduce 6 17 happyReduction_26
happyReduction_26 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (
	) `HappyStk` happyRest

happyReduce_27 = happyReduce 4 17 happyReduction_27
happyReduction_27 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 8 17 happyReduction_28
happyReduction_28 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 (
	) `HappyStk` happyRest

happyReduce_29 = happySpecReduce_3  18 happyReduction_29
happyReduction_29 _
	_
	_
	 =  HappyAbsSyn18
		 (
	)

happyReduce_30 = happyReduce 6 18 happyReduction_30
happyReduction_30 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (
	) `HappyStk` happyRest

happyReduce_31 = happyReduce 6 18 happyReduction_31
happyReduction_31 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (
	) `HappyStk` happyRest

happyReduce_32 = happyReduce 4 18 happyReduction_32
happyReduction_32 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (
	) `HappyStk` happyRest

happyReduce_33 = happyReduce 4 18 happyReduction_33
happyReduction_33 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (
	) `HappyStk` happyRest

happyReduce_34 = happyReduce 8 18 happyReduction_34
happyReduction_34 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (
	) `HappyStk` happyRest

happyReduce_35 = happySpecReduce_2  19 happyReduction_35
happyReduction_35 _
	_
	 =  HappyAbsSyn19
		 (
	)

happyReduce_36 = happyReduce 4 20 happyReduction_36
happyReduction_36 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_3  20 happyReduction_37
happyReduction_37 _
	_
	_
	 =  HappyAbsSyn20
		 (
	)

happyReduce_38 = happySpecReduce_0  20 happyReduction_38
happyReduction_38  =  HappyAbsSyn20
		 (
	)

happyReduce_39 = happySpecReduce_3  21 happyReduction_39
happyReduction_39 _
	_
	_
	 =  HappyAbsSyn21
		 (
	)

happyReduce_40 = happySpecReduce_1  21 happyReduction_40
happyReduction_40 _
	 =  HappyAbsSyn21
		 (
	)

happyReduce_41 = happySpecReduce_3  22 happyReduction_41
happyReduction_41 _
	_
	_
	 =  HappyAbsSyn22
		 (
	)

happyReduce_42 = happySpecReduce_1  22 happyReduction_42
happyReduction_42 _
	 =  HappyAbsSyn22
		 (
	)

happyReduce_43 = happySpecReduce_3  23 happyReduction_43
happyReduction_43 _
	_
	_
	 =  HappyAbsSyn23
		 (
	)

happyReduce_44 = happySpecReduce_3  23 happyReduction_44
happyReduction_44 _
	_
	_
	 =  HappyAbsSyn23
		 (
	)

happyReduce_45 = happySpecReduce_3  23 happyReduction_45
happyReduction_45 _
	_
	_
	 =  HappyAbsSyn23
		 (
	)

happyReduce_46 = happySpecReduce_3  23 happyReduction_46
happyReduction_46 _
	_
	_
	 =  HappyAbsSyn23
		 (
	)

happyReduce_47 = happySpecReduce_3  23 happyReduction_47
happyReduction_47 _
	_
	_
	 =  HappyAbsSyn23
		 (
	)

happyReduce_48 = happySpecReduce_3  23 happyReduction_48
happyReduction_48 _
	_
	_
	 =  HappyAbsSyn23
		 (
	)

happyReduce_49 = happySpecReduce_3  24 happyReduction_49
happyReduction_49 _
	_
	_
	 =  HappyAbsSyn24
		 (
	)

happyReduce_50 = happySpecReduce_3  24 happyReduction_50
happyReduction_50 _
	_
	_
	 =  HappyAbsSyn24
		 (
	)

happyReduce_51 = happySpecReduce_3  25 happyReduction_51
happyReduction_51 _
	_
	_
	 =  HappyAbsSyn25
		 (
	)

happyReduce_52 = happySpecReduce_3  25 happyReduction_52
happyReduction_52 _
	_
	_
	 =  HappyAbsSyn25
		 (
	)

happyReduce_53 = happySpecReduce_1  25 happyReduction_53
happyReduction_53 _
	 =  HappyAbsSyn25
		 (
	)

happyReduce_54 = happySpecReduce_2  26 happyReduction_54
happyReduction_54 _
	_
	 =  HappyAbsSyn26
		 (
	)

happyReduce_55 = happySpecReduce_1  26 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn26
		 (
	)

happyReduce_56 = happySpecReduce_1  27 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn27
		 (
	)

happyReduce_57 = happySpecReduce_1  27 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn27
		 (
	)

happyReduce_58 = happySpecReduce_3  27 happyReduction_58
happyReduction_58 _
	_
	_
	 =  HappyAbsSyn27
		 (
	)

happyReduce_59 = happySpecReduce_1  27 happyReduction_59
happyReduction_59 _
	 =  HappyAbsSyn27
		 (
	)

happyReduce_60 = happySpecReduce_1  27 happyReduction_60
happyReduction_60 _
	 =  HappyAbsSyn27
		 (
	)

happyReduce_61 = happyReduce 4 27 happyReduction_61
happyReduction_61 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (
	) `HappyStk` happyRest

happyReduce_62 = happyReduce 4 27 happyReduction_62
happyReduction_62 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (
	) `HappyStk` happyRest

happyReduce_63 = happySpecReduce_1  27 happyReduction_63
happyReduction_63 _
	 =  HappyAbsSyn27
		 (
	)

happyReduce_64 = happyReduce 5 27 happyReduction_64
happyReduction_64 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (
	) `HappyStk` happyRest

happyReduce_65 = happySpecReduce_1  28 happyReduction_65
happyReduction_65 _
	 =  HappyAbsSyn28
		 (
	)

happyReduce_66 = happySpecReduce_0  28 happyReduction_66
happyReduction_66  =  HappyAbsSyn28
		 (
	)

happyReduce_67 = happySpecReduce_1  29 happyReduction_67
happyReduction_67 _
	 =  HappyAbsSyn29
		 (
	)

happyReduce_68 = happySpecReduce_3  29 happyReduction_68
happyReduction_68 _
	_
	_
	 =  HappyAbsSyn29
		 (
	)

happyReduce_69 = happySpecReduce_1  30 happyReduction_69
happyReduction_69 _
	 =  HappyAbsSyn30
		 (
	)

happyReduce_70 = happySpecReduce_0  30 happyReduction_70
happyReduction_70  =  HappyAbsSyn30
		 (
	)

happyReduce_71 = happySpecReduce_1  31 happyReduction_71
happyReduction_71 _
	 =  HappyAbsSyn31
		 (
	)

happyReduce_72 = happySpecReduce_3  31 happyReduction_72
happyReduction_72 _
	_
	_
	 =  HappyAbsSyn31
		 (
	)

happyReduce_73 = happySpecReduce_3  32 happyReduction_73
happyReduction_73 _
	_
	_
	 =  HappyAbsSyn32
		 (
	)

happyReduce_74 = happySpecReduce_1  33 happyReduction_74
happyReduction_74 _
	 =  HappyAbsSyn33
		 (
	)

happyReduce_75 = happySpecReduce_0  33 happyReduction_75
happyReduction_75  =  HappyAbsSyn33
		 (
	)

happyReduce_76 = happySpecReduce_1  34 happyReduction_76
happyReduction_76 _
	 =  HappyAbsSyn34
		 (
	)

happyReduce_77 = happySpecReduce_3  34 happyReduction_77
happyReduction_77 _
	_
	_
	 =  HappyAbsSyn34
		 (
	)

happyNewToken action sts stk [] =
	action 78 78 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	While _ -> cont 35;
	For _ -> cont 36;
	To _ -> cont 37;
	Break _ -> cont 38;
	Let _ -> cont 39;
	In _ -> cont 40;
	End _ -> cont 41;
	Function _ -> cont 42;
	Var _ -> cont 43;
	Type _ -> cont 44;
	Array _ -> cont 45;
	If _ -> cont 46;
	Then _ -> cont 47;
	Else _ -> cont 48;
	Do _ -> cont 49;
	Of _ -> cont 50;
	Nil _ -> cont 51;
	Comma _ -> cont 52;
	Colon _ -> cont 53;
	Semicolon _ -> cont 54;
	LParen _ -> cont 55;
	RParen _ -> cont 56;
	LBracket _ -> cont 57;
	RBracket _ -> cont 58;
	LBrace _ -> cont 59;
	RBrace _ -> cont 60;
	Dot _ -> cont 61;
	Plus _ -> cont 62;
	Minus _ -> cont 63;
	Times _ -> cont 64;
	Divide _ -> cont 65;
	Eq _ -> cont 66;
	Neq _ -> cont 67;
	Lt _ -> cont 68;
	Le _ -> cont 69;
	Gt _ -> cont 70;
	Ge _ -> cont 71;
	And _ -> cont 72;
	Or _ -> cont 73;
	Assign _ -> cont 74;
	StrLiteral _ happy_dollar_dollar -> cont 75;
	IntLiteral _ happy_dollar_dollar -> cont 76;
	Id _ happy_dollar_dollar -> cont 77;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 78 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Either String a -> (a -> Either String b) -> Either String b
happyThen = ((>>=))
happyReturn :: () => a -> Either String a
happyReturn = (return)
happyThen1 m k tks = ((>>=)) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Either String a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> Either String a
happyError' = (\(tokens, _) -> parseError tokens)
parse tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> Either String a
parseError tokens = Left $ "parse error" ++ show tokens
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 15 "<built-in>" #-}
{-# LINE 1 "/Users/saffron/.stack/programs/x86_64-osx/ghc-8.6.3/lib/ghc-8.6.3/include/ghcversion.h" #-}
















{-# LINE 16 "<built-in>" #-}
{-# LINE 1 "/var/folders/fk/skj0_h1j369ch7z_hdn7bxy40000gn/T/ghc37208_0/ghc_2.h" #-}

































































































































































































{-# LINE 17 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 










{-# LINE 43 "templates/GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList








{-# LINE 65 "templates/GenericTemplate.hs" #-}


{-# LINE 75 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action


{-# LINE 137 "templates/GenericTemplate.hs" #-}


{-# LINE 147 "templates/GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

