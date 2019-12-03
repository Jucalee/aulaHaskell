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
  

getHomeR :: Handler Html
getHomeR = do
    defaultLayout $ do
        addStylesheet (StaticR css_animate_css)
        addStylesheet (StaticR css_icomoon_css)
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheet (StaticR css_superfish_css)
        addStylesheet (StaticR css_style_css)
        addScript (StaticR js_jquery_js)
        addScript (StaticR js_modernizr_js)
        addScript (StaticR js_easing_js)
        addScript (StaticR js_bootstrap_js)
        addScript (StaticR js_waypoints_js)
        addScript (StaticR js_stellar_js)
        addStylesheetRemote "https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,700,300"
        toWidget $(juliusFile "templates/julius/hoverIntent.julius")
        toWidget $(juliusFile "templates/julius/superfish.julius")
        toWidget $(juliusFile "templates/julius/main.julius")
        $(whamletFile "templates/homepage.hamlet")
        
getBandaR :: Handler Html
getBandaR = do
    defaultLayout $ do
        defaultLayout $ do
        addStylesheet (StaticR css_animate_css)
        addStylesheet (StaticR css_icomoon_css)
        addStylesheet (StaticR css_bootstrap_css)
        addStylesheet (StaticR css_superfish_css)
        addStylesheet (StaticR css_style_css)
        addScript (StaticR js_jquery_js)
        addScript (StaticR js_modernizr_js)
        addScript (StaticR js_easing_js)
        addScript (StaticR js_bootstrap_js)
        addScript (StaticR js_waypoints_js)
        addScript (StaticR js_stellar_js)
        addStylesheetRemote "https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,700,300"
        toWidget $(juliusFile "templates/julius/hoverIntent.julius")
        toWidget $(juliusFile "templates/julius/superfish.julius")
        toWidget $(juliusFile "templates/julius/main.julius")
        $(whamletFile "templates/banda.hamlet")
        
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
