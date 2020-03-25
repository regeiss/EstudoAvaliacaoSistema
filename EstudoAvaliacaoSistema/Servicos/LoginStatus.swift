//
//  LoginStatus.swift
//  EstudoAvaliacaoSistema
//
//  Created by Roberto Edgar Geiss on 23/03/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
// ===============================================================
// Classe de estudo talvez nao seja utilizada
// ===============================================================

import Foundation

class LoginStatus
{
    private let notificationCenter: NotificationCenter
    init(notificationCenter: NotificationCenter = .default) {self.notificationCenter = notificationCenter}
    
    private var estadoLogin = Status.deslogado
    {
        didSet { stateDidChange() }
    }

    func logar(_ usuario: Usuario)
    {
        estadoLogin = .logado(usuario)
//        startPlayback(with: item)
    }

    func bloquear(_ usuario: Usuario)
    {
        switch estadoLogin
        {
        case .deslogado, .bloqueado(usuario):
            break
        case .logado(let usuario):
            estadoLogin = .bloqueado(usuario)
//            pausePlayback()
        case .bloqueado(_):
            estadoLogin = .bloqueado(usuario)
        }
    }

    func deslogar()
    {
        estadoLogin = .deslogado
//        stopPlayback()
    }
}

private extension LoginStatus
{
    enum Status
    {
        case deslogado
        case logado(Usuario)
        case bloqueado(Usuario)
    }
}

private extension LoginStatus
{
    func stateDidChange()
    {
        switch estadoLogin
        {
            case .deslogado:
                notificationCenter.post(name: .deslogadoUsuario, object: nil)
            case .logado(let status):
                notificationCenter.post(name: .logadoUsuario, object: status)
            case .bloqueado(let status):
                notificationCenter.post(name: .bloqueadoUsuario, object: status)
        }
    }
}

extension Notification.Name
{
    static var logadoUsuario: Notification.Name {return .init(rawValue: "LoginStatus.logado")}
    static var bloqueadoUsuario: Notification.Name {return .init(rawValue: "LoginStatus.bloqueado")}
    static var deslogadoUsuario: Notification.Name {return .init(rawValue: "LoginStatus.deslogado")}
    
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}
