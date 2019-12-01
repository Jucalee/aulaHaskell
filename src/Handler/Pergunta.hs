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

-- renderDivs
formPergunta :: Form Pergunta
formPergunta = renderBootstrap $ Pergunta
    <$> areq textField "Descrição: " Nothing
    <*> aopt textField "Imagem: " Nothing
    

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
    ((result,_),_) <- runFormPost formAtor
    case result of 
        FormSuccess pergunta -> do 
            runDB $ insert pergunta 
            setMessage [shamlet|
                <div>
                    Pergunta incluida
            |]
            redirect PerguntaR
        _ -> redirect HomeR
        
-- getListQuestR :: Handler Html
-- getListQuestR = do
--     let sql = "SELECT ??, ?? FROM pergunta \
--           \ INNER JOIN alternativa ON pergunta.id = alternativa.perguntaid"
--     defaultLayout $ do
--         $(whamletFile "templates/list-questions.hamlet")