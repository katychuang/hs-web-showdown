{-# LANGUAGE OverloadedStrings #-}

import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Control.Exception
import Data.IORef
import Control.Applicative   ((<$>))
import Data.ByteString.Lazy
import Data.ByteString
import Data.Aeson
import Data.Maybe

manager :: IO (IORef Manager)
manager = newManager settings >>= newIORef
  where settings = tlsManagerSettings {
    managerConnCount       = 100
  , managerResponseTimeout = Just 2000000 -- 2 secs
}

ourRequest' = ourRequest { requestHeaders = [("User-Agent", "katurday")] }

ourRequest :: Request
ourRequest = case (parseUrl "https://api.github.com/search/code?q=addClass+in:file+language:js+repo:jquery/jquery") of
  Just x -> x
  Nothing -> error "bad"

main = print "hi"

--getReq :: IO (Either e0 Data.ByteString.ByteString)
getReq = manager >>= readIORef >>= \man -> toStrict . responseBody <$> httpLbs ourRequest' man

jsonStuff =  getReq  >>= \response -> return $ (fromJust (decode (fromChunks [response]) :: Maybe Value))

