//
//  LoginStatus.swift
//  EstudoAvaliacaoSistema
//
//  Created by Roberto Edgar Geiss on 23/03/20.
//  Copyright © 2020 Roberto Edgar Geiss. All rights reserved.
//

import Foundation

class LoginStatus
{
    init(notificationCenter: NotificationCenter = .default) {self.notificationCenter = notificationCenter}
    
    private let notificationCenter: NotificationCenter
    private var state = Status.deslogado
    {
        // We add a property observer on 'state', which lets us
        // run a function on each value change.
        didSet { stateDidChange() }
    }

    func play(_ usuario: Usuario)
    {
        state = .logado(usuario)
//        startPlayback(with: item)
    }

    func pause(_ usuario: Usuario)
    {
        switch state
        {
        case .deslogado, .bloqueado(usuario):
            // Calling pause when we're not in a playing state
            // could be considered a programming error, but since
            // it doesn't do any harm, we simply break here.
            break
        case .logado(let usuario):
            state = .bloqueado(usuario)
//            pausePlayback()
        case .bloqueado(_):
            state = .bloqueado(usuario)
        }
    }

    func stop()
    {
        state = .deslogado
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
        switch state {
        case .deslogado:
            notificationCenter.post(name: .playbackStopped, object: nil)
        case .logado(let status):
            notificationCenter.post(name: .playbackStarted, object: status)
        case .bloqueado(let status):
            notificationCenter.post(name: .playbackPaused, object: status)
        }
    }
}

extension Notification.Name
{
    static var playbackStarted: Notification.Name {return .init(rawValue: "AudioPlayer.playbackStarted")}
    static var playbackPaused: Notification.Name {return .init(rawValue: "AudioPlayer.playbackPaused")}
    static var playbackStopped: Notification.Name {return .init(rawValue: "AudioPlayer.playbackStopped")}
}
