{-# LANGUAGE OverloadedStrings #-}
module DesafioSpec where
import qualified Hedgehog.Gen           as Gen
import qualified Hedgehog.Range         as Range
import           Test.Hspec
import           Test.Hspec.Hedgehog
import           Hedgehog

testearSuma = do
   hspec $
      describe "testear suma" $ do
         it "placeholder" $ do
            True `shouldBe` True
         
   checkParallel $ Group "Desafio: testear la suma" [
      ("unaProperty", unaProperty)
    ]

unaProperty = undefined

add :: Integer -> Integer -> Integer
add a b = undefined
