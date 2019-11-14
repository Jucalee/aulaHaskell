{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
--import Network.HTTP.Types.Status
import Text.Lucius
import Text.Julius
import Database.Persist.Postgresql


getPage2R :: Handler Html 
getPage2R = do 
    defaultLayout $ do 
        $(whamletFile "templates/page2.hamlet")

getPage1R :: Handler Html
getPage1R = do
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead $(juliusFile "templates/page1.julius")
        toWidgetHead $(luciusFile "templates/page1.lucius")
        $(whamletFile "templates/page1.hamlet")        

getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        -- remoto
        -- addScriptRemote "link min do JQuery"
        -- está no projeto
        addStylesheet (StaticR css_bootstrap_css)
        sess <- lookupSession "_NOME"
        toWidgetHead [julius|
            function ola() {
                alert("OLA MUNDO");
            }
        |]
        toWidgetHead [lucius|
            h1 {
                color : red;
            }
            
            ul {
                display: inline;
                list-style: none;
            }
        |]
        [whamlet|
            <div>
                <h1>
                    OLA MUNDO

            <ul>
                <li>
                    <a href=@{Page1R}>
                        Pagina 1
                        
                <li>
                    <a href=@{Page2R}>
                        Pagina 2

                $maybe nome <- sess
                    <li>
                        <div>
                            Ola #{nome}
                        <form method=post action=@{SairR}>
                            <input type="submit" value="Sair">
                            
                $nothing
                    <li>
                        <div>
                            CONVIDADO
                    
            <button class"btn btn-danger" onclick="ola()">
                OK
        |]
