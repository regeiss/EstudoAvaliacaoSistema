//
//  ViewController.swift
//  EstudoAvaliacaoSistema
//
//  Created by Roberto Edgar Geiss on 17/03/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
//

import Foundation
import UIKit
import Network
import CoreData

class LoginVC: UIViewController, UITextFieldDelegate, NetworkCheckObserver
{
    // MARK: - Campos da tela outlets
    @IBOutlet weak var txtStatusLabel: UILabel!
    @IBOutlet weak var txtUsuario: UITextField!
    @IBAction func txtUsuario(_ sender: UITextField) {
    }
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    // MARK: - Variaveis
    var networkCheck = NetworkCheck.sharedInstance()
    var container: NSPersistentContainer!
    var usuario = [Usuario]()
//    let transiton = SlideInTransition()
    var topView: UIView?
    var disparaSegue: Bool = false

    // MARK: - Ciclo de vida da view
    override func viewDidLoad()
    {
        super.viewDidLoad()
        InicializaViewLogin()
    }

    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        networkCheck.removeObserver(observer: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        switch textField
        {
            case txtUsuario:
                txtUsuario.resignFirstResponder()
                txtSenha.becomeFirstResponder()
            case txtSenha:
                txtSenha.resignFirstResponder()
            default:
                break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        switch textField
        {
            case txtUsuario:
                txtUsuario.resignFirstResponder()
                txtSenha.becomeFirstResponder()
            case txtSenha:
                txtSenha.resignFirstResponder()
            default:
                break
        }
        return true;
    }

    // MARK: Iniciliazacao
    fileprivate func InicializaViewLogin()
    {
        // Notificacao para mover o teclado.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        // Ajustes dos delegates
        txtUsuario.delegate = self
        txtSenha.delegate = self
        
        // Ajustes do botao
        btnLogin.layer.cornerRadius = 10
        btnLogin.clipsToBounds = true
        btnLogin.backgroundColor = UIColor.systemGray
        btnLogin.titleLabel?.textColor =  UIColor.systemYellow
        
        // Comportamento dos campos
        txtUsuario.borderStyle = .roundedRect
        txtUsuario.backgroundColor = UIColor.systemGray6
        txtSenha.borderStyle = .roundedRect
        txtSenha.backgroundColor = UIColor.systemGray6
        txtUsuario.returnKeyType = .next
        
        //deletaUsuario()
        //buscaUsuario()
    }
    
    // MARK: - Move a tela para mostrar o teclado
    @objc func keyboardWillShow(sender: NSNotification)
    {
        self.view.frame.origin.y = -150
    }
    
    @objc func keyboardWillHide(sender: NSNotification)
    {
        self.view.frame.origin.y = 0
    }
    
    func displayErrorMessage(title: String, message:String)
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {(action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        self.present(alertView, animated: true, completion: nil)
    }

    // MARK: - Mantem status da conexao
    func statusDidChange(status: NWPath.Status)
    {
        txtStatusLabel.text = status == .satisfied ? "Conectado" : "Desconectado"
    }
    
    // MARK: - Valida entrada de dados
    func validaEntrada() -> Bool
    {
        var retorno: Bool = true
        let usuarioValido = Login()
        
        if txtUsuario.text!.isEmpty
        {
            displayErrorMessage(title: "Aviso", message: "Usuário deve ser informado")
            retorno = false
        }
        else if txtSenha.text!.isEmpty
        {
            displayErrorMessage(title: "Aviso", message: "Senha deve ser informada")
            retorno = false
        }
        
        if usuarioValido.validaUsuario(login: txtUsuario.text!, senha: txtSenha.text!) == false
        {
            retorno = false
            displayErrorMessage(title: "Aviso", message: "Usuário ou senha inválido")
        }
        return retorno
    }

//===============================================================================================================================================
    // MARK: - Funcoes do coredata
     private func salvaUsuario()
     {
         let usuario = Usuario(context: Persistencia.context)
         usuario.nome = txtUsuario.text
         usuario.senha = txtSenha.text
         usuario.logado = true
         usuario.dataUltimoLogin = Date()
         usuario.email = "teste@teste.com.br"
         Persistencia.saveContext()
     }
     
     private func buscaUsuario()
     {
         let fetchRequest: NSFetchRequest<Usuario> = Usuario.fetchRequest()
         do
         {
             let formatoData = DateFormatter()
             formatoData.dateStyle = .full
             
             let usuario = try Persistencia.context.fetch(fetchRequest)
             self.usuario = usuario
             if self.usuario.count > 0
             {
                 self.usuario.forEach({print($0.nome!)})
             }
         }
         catch
         {
             // verificacao de erros aqui
             print("Ocorreu um erro de core data")
         }
     }
     
     private func deletaUsuario()
      {
         let usuario = Usuario(context: Persistencia.context)
         Persistencia.context.delete(usuario) // .fetch(fetchRequest)
         print("Usuário excluído")
     }
}

