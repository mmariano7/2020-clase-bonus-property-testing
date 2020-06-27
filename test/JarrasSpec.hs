module JarrasSpec where
import qualified Hedgehog.Gen           as Gen
import qualified Hedgehog.Range         as Range
import           Test.Hspec
import           Test.Hspec.Hedgehog
import           Hedgehog

buscarSolucion :: IO Bool
buscarSolucion = check . property $ do
   2 === 2
