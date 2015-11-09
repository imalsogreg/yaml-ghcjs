{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE JavaScriptFFI #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE CPP #-}

module Data.Yaml where

import qualified Data.Aeson as A
import qualified Data.Text  as T
import           GHCJS.Marshal
import           GHCJS.Foreign
import           GHCJS.Types

decodeYaml :: A.FromJSON a => T.Text -> IO (Maybe a)
decodeYaml t = do
  let x = y_load (toJSString t)
  y <- fromJSRef x
  case A.fromJSON <$> y of
    Just (A.Success v) -> return v
    _                  -> return Nothing


#ifdef __GHCJS__
foreign import javascript unsafe "jsyaml.load($1)" y_load :: JSString -> JSRef A.Value
#else
y_load = error "y_load only supported by ghcjs"
#endif

