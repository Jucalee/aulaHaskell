{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Usuario where

import Import
-- import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Text.Lucius
import Text.Julius

-- renderDivs
formUsu :: Form (Usuario, Text)
formUsu = renderBootstrap $ (,)
    <$> (Usuario
        <$> areq textField "Nome: " Nothing
        <*> areq emailField "Email: " Nothing
        <*> areq passwordField "Senha: " Nothing)
    <*> areq passwordField "Digite novamente: " Nothing
    
getUsuarioR :: Handler Html
getUsuarioR = do
    (widget, _) <- generateFormPost formUsu
    msg <- getMessage
    defaultLayout $
        [whamlet|
            $maybe mensa <- msg
                <div>
                    ^{mensa}
            <h1>
                CADASTRO DE USUARIO
            <form method=post action=@{UsuarioR}>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]

postUsuarioR :: Handler Html
postUsuarioR = do 
    ((result,_),_) <- runFormPost formUsu
    case result of
        FormSuccess (usuario,veri) -> do
            if (usuarioSenha usuario == veri) then do
                runDB $ insert usuario
                setMessage [shamlet| 
                    <div>
                        USUARIO INCLUIDO
                |]
                redirect UsuarioR
            else do
                setMessage [shamlet|
                    <div>
                        SENHA E VERIFICACAO N SAO IDENTICAS
                |]
                redirect UsuarioR
        _ -> redirect HomeR