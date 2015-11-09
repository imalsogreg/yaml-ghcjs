{-# LANGUAGE ForeignFunctionInterface, JavaScriptFFI, CPP #-}

module Data.Yaml.Internal where

import qualified Data.Aeson as A
import GHCJS.Foreign
import GHCJS.Types

#ifdef __GHCJS__
foreign import javascript unsafe "load($1)" y_load :: A.FromJSON a => JSString -> JSObject a
#else
y_load = error "y_load only supported by ghcjs"
#endif
