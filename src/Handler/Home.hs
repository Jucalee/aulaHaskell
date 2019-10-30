{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Network.HTTP.Types.Status
import Database.Persist.Postgresql

getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        -- remoto
        -- addScriptRemote "link min do JQuery"
        -- está no projeto
        addStylesheet (StaticR css_bootstrap_css)
        [whamlet|
            <div>
                <h1> 
                    OLA MUNDO
                    
            <button class"btn btn-danger" onclick="ola()">
                OK
        |]
