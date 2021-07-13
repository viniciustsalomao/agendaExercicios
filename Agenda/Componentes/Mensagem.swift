//
//  Mensagem.swift
//  Agenda
//
//  Created by Vinícius Tinajero Salomão on 08/07/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import MessageUI

class Mensagem: NSObject {
    
    var delegate: MFMessageComposeViewControllerDelegate?
    
    func setaDelegate() -> MFMessageComposeViewControllerDelegate? {
        delegate = self
        
        return delegate
    }

    // MARK: - Metodos
    func enviaSMS(_ aluno: Aluno, controller: UIViewController) {
        if MFMessageComposeViewController.canSendText() {
            let componenteMensagem = MFMessageComposeViewController()
            guard let numeroDoAluno = aluno.telefone else { return }
            componenteMensagem.recipients = [numeroDoAluno]
            
            guard let delegate = setaDelegate() else { return }
            componenteMensagem.messageComposeDelegate = delegate
            controller.present(componenteMensagem, animated: true, completion: nil)
        }
    }
}

extension Mensagem: MFMessageComposeViewControllerDelegate {
    
    // MARK: - MessageComposeDelegate
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
