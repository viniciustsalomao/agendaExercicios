//
//  MenuOpcoesAlunos.swift
//  Agenda
//
//  Created by Vinícius Tinajero Salomão on 08/07/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit

enum MenuActionSheetAluno {
    case sms
    case ligacao
    case waze
    case mapa
    case abrirPaginaWeb
}

class MenuOpcoesAlunos: NSObject {
    func configuraMenuDeOpcoesDoAluno (completion: @escaping(_ opcao: MenuActionSheetAluno) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Atenção", message: "escolha uma das opções abaixo", preferredStyle: .actionSheet)
        let sms = UIAlertAction(title: "enviar SMS", style: .default) { (acao) in
            completion(.sms)
        }
        menu.addAction(sms)
        
        let ligacao = UIAlertAction(title: "fazer ligação", style: .default) { (acao) in
            completion(.ligacao)
        }
        menu.addAction(ligacao)
        
        let waze = UIAlertAction(title: "traçar rota no Waze", style: .default) { (acao) in
            completion(.waze)
        }
        menu.addAction(waze)
        
        let mapa = UIAlertAction(title: "localizar no mapa", style: .default) { (acao) in
            completion(.mapa)
        }
        menu.addAction(mapa)
        
        let abrirPaginaWeb = UIAlertAction(title: "abrir página web", style: .default) { (acao) in
            completion(.abrirPaginaWeb)
        }
        menu.addAction(abrirPaginaWeb)
        
        let cancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        
        return menu
    }
}
