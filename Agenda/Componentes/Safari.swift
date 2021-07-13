//
//  Safari.swift
//  Agenda
//
//  Created by Vinícius Tinajero Salomão on 13/07/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import SafariServices

class Safari: NSObject {

    func abrePaginaWeb(_ alunoSelecionado: Aluno, controller: UIViewController) {
        if let urlDoAluno = alunoSelecionado.site {

            var urlFormadata = urlDoAluno
            if !urlFormadata.hasPrefix("http://") {
                urlFormadata = String(format: "http://%@", urlFormadata)
            }

            guard let url = URL(string: urlFormadata) else { return }

            let safariViewController = SFSafariViewController(url: url)
            controller.present(safariViewController, animated: true, completion: nil)
        }
    }
    
}
