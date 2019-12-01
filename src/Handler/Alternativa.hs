{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Alternativa where

import Import
-- import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Text.Lucius
import Text.Julius

perguntaCB = do
  rows <- runDB $ selectList [] [Asc PerguntaDescricao]
  optionsPairs $ 
      map (\r -> (perguntaDescricao $ entityVal r, entityKey r)) rows

formAlternativa :: Form Atua 
formAlternativa = renderBootstrap $ Atua
    <$> areq (selectField perguntaCB) "Pergunta: " Nothing
    <$> areq textField "Alternativa: " Nothing --testar

postAlternativaR :: Handler Html
postAlternativaR = do
    ((result,_),_) <- runFormPost formAlternativa
    case result of
        FormSuccess alternativa -> do
            runDB $ insert alternativa
            setMessage [shamlet|
                <h2>
                    ALTERNATIVA INSERIDA COM SUCESSO
            |]
            redirect AlternativaR
        _ -> redirect HomeR

getAlternativaR :: Handler Html
getAlternativaR = do 
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