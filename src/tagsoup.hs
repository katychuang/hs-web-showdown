{-# LANGUAGE OverloadedStrings #-}
import Network.HTTP		as H
import Network.HTTP.Conduit	as C
import qualified Data.ByteString.Lazy as LB
import System.IO
import qualified Data.Text 			as T

openURL x = getResponseBody =<< simpleHttp (H.getRequest x)
openURL' x = getResponseBody =<< simpleHttp (H.getRequest x)  

--main = do src <- openURL "https://github.com/search?p=1&utf8=%E2%9C%93&q=transformers+snap-server+extension%3Acabal&type=Code&ref=searchresults" 
--	  writeFile "temp.htm" src

n = [1..49]

--main = simpleHttp "https://github.com/search?p=1&utf8=%E2%9C%93&q=transformers+snap-server+extension%3Acabal&type=Code&ref=searchresults" 
--	>>= LB.putStr

main = do src <- openURL' "https://github.com/search?p=1&utf8=%E2%9C%93&q=transformers+snap-server+extension%3Acabal&type=Code&ref=searchresults"
--	writeFile "temp1.htm" src
	  writeFile "temp1.htm" $ src



-- Notes
-- Using Tag soup: 
-- https: http://stackoverflow.com/questions/21296606/resolving-network-http-user-error-https-not-supported
--
