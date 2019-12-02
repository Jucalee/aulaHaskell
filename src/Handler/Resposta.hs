{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Resposta where

import Import
-- import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Text.Lucius
import Text.Julius

perguntaCB = do
  rows <- runDB $ selectList [] [Asc PerguntaDescricao]
  optionsPairs $ 
      map (\r -> (perguntaDescricao $ entityVal r, entityKey r)) rows

formResposta :: Form Resposta 
formResposta = renderBootstrap $ Alternativa
    <$> areq (selectField perguntaCB) "Pergunta: " Nothing
    <*> areq textField "Alternativa: " Nothing --testar
    <*> areq boolField "É correta?: " Nothing

postRespostaR :: Handler Html
postRespostaR = do
    ((result,_),_) <- runFormPost formAlternativa
    case result of
        FormSuccess resposta -> do
            runDB $ insert resposta
            setMessage [shamlet|
                <h2>
                    ALTERNATIVA INSERIDA COM SUCESSO
            |]
            redirect AlternativaR
        _ -> redirect HomeR

getRespostaR :: Handler Html
getRespostaR = do 
    (widget,_) <- generateFormPost formAlternativa
    msg <- getMessage
    defaultLayout $ 
        [whamlet|
            $maybe mensa <- msg 
                <div>
                    ^{mensa}
            
            <h1>
                CADASTRO DE RESPOSTA
            
            <form method=post action=@{AlternativaR}>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]
        

-- getAlternativeListR :: PerguntaId -> Handler Html
-- getAlternativeListR serieid = do 
--     let sql = "SELECT descricao FROM resposta \
--           \ INNER JOIN pergunta ON pergunta.id = resposta.perguntaId \
--           \ WHERE pergunta.id = ?"
--     resposta <- runDB $ get404 respostaid
--     pergunta <- runDB $ rawSql sql [toPersistValue perguntaid] :: Handler [(Entity Pergunta,Entity Serie,Entity Ator)]
--     defaultLayout $ do 
--         [whamlet|
--             <h1>
--                 ELENCO DE #{serieNome serie}
--             <ul>
--                 $forall (Entity _ _, Entity _ _, Entity _ ator) <- atores
--                     <li>
--                         #{atorNome ator}
--         |]