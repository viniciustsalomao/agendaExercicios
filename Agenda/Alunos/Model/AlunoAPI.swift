//
//  AlunoAPI.swift
//  Agenda
//
//  Created by Vinícius Tinajero Salomão on 12/07/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import Alamofire

class AlunoAPI: NSObject {
    
    // MARK: - GET
    
    func recuperaAlunos(completion: @escaping() -> Void) {
        Alamofire.request("https://my-json-server.typicode.com/viniciustsalomao/fakeAPI-alunos", method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let resposta = response.result.value as? Dictionary<String,Any> {
                    guard let listaDeAlunos = resposta["alunos"] as? Array<Dictionary<String,Any>> else {return}
                    
                    for dicionarioDeAluno in listaDeAlunos {
                        AlunoDAO().salvaAluno(dicionarioDeAluno: dicionarioDeAluno)
                    }
                    completion()
                }
                break
            case .failure:
                print(response.error!)
                completion()
                break
            }
        }
    }
    
    // MARK: - PUT
    
    func salvaAlunosNoServidor(parametros: Array<Dictionary<String,String>>) {
        guard let url = URL(string: "https://my-json-server.typicode.com/viniciustsalomao/fakeAPI-alunos") else { return }
        
        var requisicao = URLRequest(url: url)
        requisicao.httpMethod = "PUT"
        
        let json = try! JSONSerialization.data(withJSONObject: parametros, options: [])
        
        requisicao.httpBody = json
        requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(requisicao)
        
    }
    
    // MARK: - DELETE
    func deletaAluno(id: String) {
        Alamofire.request("https://my-json-server.typicode.com/viniciustsalomao/fakeAPI-alunos/\(id)", method: .delete).responseJSON { (resposta) in
            switch resposta.result {
            case .failure:
                print(resposta.result.error!)
                break
            default:
                break
            }
        }
    }
    
}
