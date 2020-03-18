//
//  Login.swift
//  EstudoAvaliacaoSistema
//
//  Created by Roberto Edgar Geiss on 18/03/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
//

import Foundation

class Login
{
// MARK: - Propriedades
   var dataLogin: String = ""
   let utilitarios = Utilitarios()
   
   func validaUsuario(login: String, senha: String) -> Bool
   {
       var retorno: Bool = true
       
       if login != "rgeiss"
       {
           retorno = false
       }
       else if senha != "1234"
       {
           retorno = false
       }
       
       if retorno
       {
           atualizaDataLogin()
       }
       
       return retorno
    }
    
    func atualizaDataLogin()
    {
        // Grava hora de login
        dataLogin = utilitarios.dataLoginFormatada
        
    }
    
    func atualizaStatusLogin(status: Bool)
    {
        // Grava status de login
        var statusLogado: Bool = status
    }
}
