import           Test.HUnit

import           LexerTest

main :: IO ()
main = do
  runTestTT $ TestList
    [lexerTest]
  return ()
