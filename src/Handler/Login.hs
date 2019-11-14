{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Login where

import Import
-- import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Text.Lucius
import Text.Julius

-- renderDivs
formLogin :: Form (Text, Text)
formLogin = renderBootstrap $ (,)
    <$> areq emailField "Email: " Nothing
    <*> areq passwordField "Digite novamente: " Nothing
    
getEntrarR :: Handler Html
getEntrarR = do
    (widget, _) <- generateFormPost formLogin
    msg <- getMessage
    defaultLayout $
        [|whamlet
            $maybe mensa <- msg
                <div>
                    ^{mensa}
            <h1>
                ENTRAR
            <form method=post action=@{EntrarR}>
                ^{widget}
                <input type="submit" value="Entrar">
        |]

postEntrarR :: Handler Html
postEntrarR = do 
    ((result,_),_) <- runFormPost formLogin
    case result of
        FormSuccess (email,senha) -> do
            -- select * from usuario where email = digitado.email
            usuario <- runDB $ getBy (UniqueEmailRest email)
            case usuario of
                Nothing -> do
                    setMessage [shamlet|
                        <div>
                            E-mail N ENCONTRADO!
                    |]
                    redirect EntrarR
                Just (Entity _ usu) -> do 
                    setSession "_NOME" (usuarioNome usu)
                    redirect EntrarR
        _ -> redirect HomeR
        
postSairR :: Handler Html
postSairR = do 
    deleteSession "_NOME"
    redirect HomeR