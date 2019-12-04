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
        toWidget $(juliusFile "templates/julius/quiz.julius")
        $(whamletFile "templates/quiz.hamlet")
    
--     getImagesR = do
--   images <- runDB $ selectList [ImagesFilename !=. ""] [Desc ImagesDate]
--   returnJson (map entityVal images)
    
getSobreR :: Handler Html
getSobreR = do
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
        $(whamletFile "templates/sobre.hamlet")
