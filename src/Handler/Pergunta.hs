{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Pergunta where

import Import
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Stactus
import Database.Persist.Postgresql
--import Database.Esqueleto
import Data.Text (Text, concat)

--
-- renderDivs
formPergunta :: Form Pergunta
formPergunta = renderBootstrap $ Pergunta
    <$> areq textField "Descrição: " Nothing
--
getPerguntaR :: Handler Html
getPerguntaR = do 
    (widget,_) <- generateFormPost formPergunta
    msg <- getMessage
    defaultLayout $ 
        [whamlet|
            $maybe mensa <- msg 
                <div>
                    ^{mensa}
            
            <h1>
                CADASTRO DE PERGUNTA
            
            <form method=post action=@{PerguntaR}>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]

postPerguntaR :: Handler Html
postPerguntaR = do 
    ((result,_),_) <- runFormPost formPergunta
    case result of 
        FormSuccess pergunta -> do 
            runDB $ insert pergunta 
            setMessage [shamlet|
                <div>
                    Pergunta incluida
            |]
            redirect PerguntaR
        _ -> redirect HomeR
        
        
getListaQuestoesR :: Handler Html
getListaQuestoesR = do
    perguntas <- runDB $ selectList [] [Asc PerguntaId]
    alternativas <- runDB $ selectList [] [Asc AlternativaDescricao]
    
    defaultLayout $ do
        setTitle "Listagem de Questões"
        addStylesheet (StaticR css_bootstrap_css)
        $(whamletFile "templates/list-questions.hamlet")

        
getQuizPerguntaR :: Handler Value
getQuizPerguntaR = do
    perguntas <- runDB $ selectList [] [Asc PerguntaId]
    returnJson (map entityVal perguntas)