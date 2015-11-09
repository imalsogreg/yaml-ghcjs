{-# LANGUAGE RankNTypes, FlexibleContexts, OverloadedStrings #-}
module Data.Yaml where

import qualified Data.Aeson as A
import qualified Data.Text  as T
import           Data.Yaml.Internal (y_load)
import           GHCJS.Marshal
import           GHCJS.Foreign
import           GHCJS.Types

decodeYaml :: A.FromJSON a => T.Text -> IO (Maybe a)
decodeYaml t =
  let x = y_load (toJSString t)
      y = fromJSRef x
  in  y

y :: Int
y = let p = decodeYaml "Hello" :: Bool
    in  1
