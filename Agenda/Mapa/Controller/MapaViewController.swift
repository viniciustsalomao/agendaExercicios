//
//  MapaViewController.swift
//  Agenda
//
//  Created by Vinícius Tinajero Salomão on 08/07/21.
//  Copyright © 2021 Alura. All rights reserved.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    @IBOutlet weak var mapa: MKMapView!
    
    var aluno: Aluno?
    lazy var localizacao = Localizacao()
    lazy var gerenciadorDeLocalizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = getTitulo()
        verificaAutorizacaoDoUsuario()
        localizacaoInicial()
        
        mapa.delegate = localizacao
    }
    
    func getTitulo() -> String {
        return "Localizar Alunos"
    }
    
    func verificaAutorizacaoDoUsuario() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                let botao = Localizacao().configuraBotaoLocalizacaoAtual(mapa: mapa)
                mapa.addSubview(botao)
                gerenciadorDeLocalizacao.startUpdatingLocation()
                break
            case .notDetermined:
                gerenciadorDeLocalizacao.requestWhenInUseAuthorization()
                break
            case .denied:
                
                break
            default:
                break
            }
        }
    }
    
    func localizacaoInicial() {
        Localizacao().converteEnderecoEmCoordenadas(endereco: "Av. Brg. Faria Lima, 1306 - São Paulo") { (localizacaoEncontrada) in
//            let pino = self.configurarPino(titulo: "Iteris", localizacao: localizacaoEncontrada)
            
            let pino = Localizacao().configurarPino(titulo: "Iteris", localizacao: localizacaoEncontrada, cor: .black, icone: UIImage(named: "icon_iteris"))

            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 5000, 5000)
            
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
            self.localizacaoAluno()
        }
    }
    
    func localizacaoAluno() {
        guard let aluno = aluno else { return }
        Localizacao().converteEnderecoEmCoordenadas(endereco: aluno.endereco!) { (localizacaoEncontrada) in
//            let pino = self.configurarPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada)
            let pino = Localizacao().configurarPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada, cor: nil, icone: nil)
            self.mapa.addAnnotation(pino)
            self.mapa.showAnnotations(self.mapa.annotations, animated: true)
        }
    }
    
}

extension MapaViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            let botao = Localizacao().configuraBotaoLocalizacaoAtual(mapa: mapa)
            mapa.addSubview(botao)
            gerenciadorDeLocalizacao.startUpdatingLocation()
            break
        default:
            break
        }
    }
    
}
