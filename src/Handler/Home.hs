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
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheetRemote "https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,700,300"
        toWidgetHead $(luciusFile "templates/lucius/animate.lucius")
        toWidgetHead $(luciusFile "templates/lucius/icomoon.lucius")
        toWidgetHead $(luciusFile "templates/lucius/style.lucius")
        toWidgetHead $(luciusFile "templates/lucius/superfish.lucius")
        addScript (StaticR js_modernizr_js)
        addScriptRemote "https://code.jquery.com/jquery-3.4.1.min.js"
        addScript (StaticR js_easing_js)
        addScript (StaticR js_bootstrap_js)
        addScript (StaticR js_waypoints_js)
        addScript (StaticR js_stellar_js)
        toWidgetHead $(juliusFile "templates/julius/hoverIntent.julius")
        toWidgetHead $(juliusFile "templates/julius/superfish.julius")
        toWidgetHead $(juliusFile "templates/julius/main.julius")
        $(whamletFile "templates/homepage.hamlet")
        
getBandaR :: Handler Html
getBandaR = do
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        [whamlet|
            <h1>
                BANDA
        |]
        
getQuizR :: Handler Html
getQuizR = do
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        [whamlet|
            <h1>
                QUIZ
        |]
        
getSobreR :: Handler Html
getSobreR = do
    defaultLayout $ do
        addStylesheet (StaticR css_bootstrap_css)
        [whamlet|
            <h1>
                Sobre
        |]

-- getQuizR :: Handler Html
-- getQuizR = do
--     defaultLayout $ do
--         addStylesheet (StaticR css_bootstrap_css)
--         toWidgetHead $(juliusFile "templates/homepage.julius")
--         toWidgetHead $(luciusFile "templates/homepage.lucius")
--         $(whamletFile "templates/homepage.hamlet")