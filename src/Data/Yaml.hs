{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE JavaScriptFFI #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE CPP #-}

module Data.Yaml where

import qualified Data.Aeson    as A
import qualified Data.JSString as JSS
import qualified Data.Text     as T
import           GHCJS.Marshal
import           GHCJS.Types

decodeYaml :: A.FromJSON a => T.Text -> IO (Maybe a)
decodeYaml t = do
  let x = y_load (JSS.pack $ T.unpack $ t)
  y <- fromJSVal x
  case A.fromJSON <$> y of
    Just (A.Success v) -> return v
    _                  -> return Nothing


#ifdef __GHCJS__
foreign import javascript unsafe "jsyaml.load($1)" y_load :: JSString -> JSVal
#else
y_load = error "y_load only supported by ghcjs"
#endif

