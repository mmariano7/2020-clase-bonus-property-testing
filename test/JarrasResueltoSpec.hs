module JarrasResueltoSpec where
import qualified Hedgehog.Gen           as Gen
import qualified Hedgehog.Range         as Range
import           Test.Hspec
import           Test.Hspec.Hedgehog
import           Hedgehog

buscarSolucion :: IO Bool
buscarSolucion = check . withTests (5000 :: TestLimit) . property $ do
   accionesATomar <- forAll (Gen.list (Range.linear 0 300) (Gen.element accionesPosibles))
   assert . not $ resuelto (foldl hacer estadoInicial accionesATomar)
   
data EstadoDelProblema = Problema { litrosEnJarraGrande :: Int, litrosEnJarraChica :: Int }

resuelto :: EstadoDelProblema -> Bool
resuelto problema = litrosEnJarraGrande problema == 4

estadoInicial :: EstadoDelProblema
estadoInicial = Problema { litrosEnJarraGrande = 0, litrosEnJarraChica = 0 }

accionesPosibles = [LlenarJarraGrande, LlenarJarraChica, VaciarJarraGrande, VaciarJarraChica, PasarDeJarraGrandeAChica, PasarDeJarraChicaAGrande]

data AccionPosible =  LlenarJarraGrande
                    | LlenarJarraChica 
                    | VaciarJarraGrande
                    | VaciarJarraChica
                    | PasarDeJarraGrandeAChica
                    | PasarDeJarraChicaAGrande deriving (Show, Eq)

maxLitrosEnJarraGrande = 5
maxLitrosEnJarraChica = 3

hacer (Problema litrosEnJarraGrande litrosEnJarraChica) accion = case accion of
  LlenarJarraGrande -> Problema maxLitrosEnJarraGrande litrosEnJarraChica
  LlenarJarraChica -> Problema litrosEnJarraGrande maxLitrosEnJarraChica
  VaciarJarraGrande -> Problema 0 litrosEnJarraChica
  VaciarJarraChica -> Problema litrosEnJarraGrande 0
  PasarDeJarraGrandeAChica -> Problema (litrosEnJarraGrande - litrosPasados) (litrosEnJarraChica + litrosPasados)
    where litrosPasados = (maxLitrosEnJarraChica - litrosEnJarraChica) `min` litrosEnJarraGrande
  PasarDeJarraChicaAGrande -> Problema (litrosEnJarraGrande + litrosPasados) (litrosEnJarraChica - litrosPasados)
    where litrosPasados = (maxLitrosEnJarraGrande - litrosEnJarraGrande) `min` litrosEnJarraChica
