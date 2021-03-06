//
//  AlunoViewController.swift
//  Agenda
//
//  Created by Ândriu Coelho on 24/11/17.
//  Copyright © 2017 Alura. All rights reserved.
//

import UIKit

class AlunoViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var viewImagemAluno: UIView!
    @IBOutlet weak var imageAluno: UIImageView!
    @IBOutlet weak var buttonFoto: UIButton!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    
    @IBOutlet weak var textFieldNome: UITextField!
    @IBOutlet weak var textFieldEndereco: UITextField!
    @IBOutlet weak var textFieldTelefone: UITextField!
    @IBOutlet weak var textFieldSite: UITextField!
    @IBOutlet weak var textFieldNota: UITextField!
    
    // MARK: - Atributos
    
    let imagePicker = ImagePicker()
    var aluno: Aluno?
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.arredondaView()
        self.setup()
        NotificationCenter.default.addObserver(self, selector: #selector(aumentarScrollView(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Métodos
    
    func setup() {
        imagePicker.delegate = self
        
        guard let alunoSelecionado = aluno else { return }
        
        textFieldNome.text = alunoSelecionado.nome
        textFieldEndereco.text = alunoSelecionado.endereco
        textFieldTelefone.text = alunoSelecionado.telefone
        textFieldSite.text = alunoSelecionado.site
        textFieldNota.text = "\(alunoSelecionado.nota)"
        imageAluno.image = alunoSelecionado.foto as? UIImage
    }
    
    func arredondaView() {
        self.viewImagemAluno.layer.cornerRadius = self.viewImagemAluno.frame.width / 2
        self.viewImagemAluno.layer.borderWidth = 1
        self.viewImagemAluno.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @objc func aumentarScrollView(_ notification:Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: self.scrollViewPrincipal.frame.height + self.scrollViewPrincipal.frame.height/2)
    }
    
    func mostrarMultimidia(_ opcao: MenuOpcao) {
        
        let multimidia = UIImagePickerController()
        multimidia.delegate = imagePicker
        
        if opcao == .camera && UIImagePickerController.isSourceTypeAvailable(.camera) {
            multimidia.sourceType = .camera
        } else {
            multimidia.sourceType = .photoLibrary
        }
        self.present(multimidia, animated: true, completion: nil)
    }
    
    func montaDicionarioDeParametros() -> Dictionary<String,String> {
        
        var id = ""
        
        if aluno?.id == nil {
            id = String(describing: UUID())
        } else {
            guard let idDoAlunoExistente = aluno?.id else { return [:] }
            id = String(describing: idDoAlunoExistente)
        }
        
        guard let nome = textFieldNome.text else { return [:] }
        guard let endereco = textFieldEndereco.text else { return [:] }
        guard let telefone = textFieldTelefone.text else { return [:] }
        guard let site = textFieldSite.text else { return [:] }
        guard let nota = textFieldNota.text else { return [:] }
        
        let dicionario: Dictionary<String,String> = [
            "id": id.lowercased(),
            "nome": nome,
            "endereco": endereco,
            "telefone": telefone,
            "site": site,
            "nota": nota
        ]
        
        return dicionario
    }
    
    // MARK: - IBActions
    
    @IBAction func buttonFoto(_ sender: UIButton) {
        
        let menu = ImagePicker().menuDeOpcoes { (opcao) in
            self.mostrarMultimidia(opcao)
        }
        present(menu, animated: true, completion: nil)
        
        
    }
    
    @IBAction func stepperNota(_ sender: UIStepper) {
        self.textFieldNota.text = "\(sender.value)"
    }
    
    @IBAction func buttonSalvar(_ sender: UIButton) {

        
        let json = montaDicionarioDeParametros()
        Repositorio().salva(aluno: json)
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
}

extension AlunoViewController: ImagePickerFotoSelecionada {
    
    // MARK: - Delegate
    
    func imagePickerFotoSelecionada(_ foto: UIImage) {
        imageAluno.image = foto
    }
    
    
}
