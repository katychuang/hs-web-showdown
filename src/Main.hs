{-# LANGUAGE OverloadedStrings #-}

import qualified Github.Search as Github
import qualified Github.Data as Github
import Control.Monad (forM,forM_)
import Data.Maybe (fromMaybe)
import Data.List (intercalate)


yesodQuery :: String
yesodQuery = "q=yesod"

cool = Github.searchRepos yesodQuery >>= \either -> case (either) of
	Left e       -> error "bad"
        Right result -> return (Github.searchReposRepos result)



getRepos query = do
  response <- Github.searchRepos query
  case response of
    Left e -> error "bad"
    Right result -> 
 
main = do
    let query = "q=yesod"
    result <- Github.searchRepos query
    case result of
        Left e  -> putStrLn $ "Error: " ++ show e
        Right r -> do forM_ (Github.searchReposRepos r) (\r -> do
                        putStrLn $ formatRepo r
                        putStrLn ""
                        )
                      putStrLn $ "Count: " ++ show n
          where n = Github.searchReposTotalCount r

    --print result

formatRepo :: Github.Repo -> String
formatRepo r =
  let fields = [ ("Name", Github.repoName)
                 ,("URL",  Github.repoHtmlUrl)
                 ,("Description", orEmpty . Github.repoDescription)
                 ,("Created-At", formatDate . Github.repoCreatedAt)
                 ,("Pushed-At", formatMaybeDate . Github.repoPushedAt)
               ]
  in intercalate "\n" $ map fmt fields
    where fmt (s,f) = fill 12 (s ++ ":") ++ " " ++ f r
          orEmpty = fromMaybe ""
          fill n s = s ++ replicate n' ' '
            where n' = max 0 (n - length s)


formatMaybeDate = maybe "???" formatDate

formatDate = show . Github.fromGithubDate
