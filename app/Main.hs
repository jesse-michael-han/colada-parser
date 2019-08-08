{-# LANGUAGE OverloadedStrings #-}
{-
Author(s): Jesse Michael Han (2019)
-}

module Main where

import CNLean.Basic.Basic
import CNLean.Core
import qualified Data.Text.IO as TIO
import System.Environment
import System.Directory
import Control.Monad.Trans.State
import Control.Monad.Trans.State.Lazy
import Text.Megaparsec

main :: IO ()
main = do
  file <- (head <$> getArgs)
  txt <- makeAbsolute file >>= TIO.readFile 
  case (runParser (toParsec parseProgram) "" txt) of
    Left err -> fail $ show err
    Right a -> do
      let output = show a
      putStrLn output
      writeFile (file <> "CNL") output

