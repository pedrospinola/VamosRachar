//
//  ViewController.swift
//  Vamos Rachar
//
//  Created by Pedro Henrique Spínola de Assis on 02/03/20.
//  Copyright © 2020 Pedro Henrique Spínola de Assis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var km: String = ""
    var autonomia: String = ""
    var consumoUser: [Float] = [UserDefaults.standard.object(forKey: "consumo0") as? Float ?? 0.0,UserDefaults.standard.object(forKey: "consumo1") as? Float ?? 0.0]
    let user: [String] = ["Usuário 01", "Usuário 02"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue

        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBOutlet weak var fundoLabel: UILabel!
    
    @IBOutlet weak var userX: UISegmentedControl!
    
    @IBOutlet weak var imagemCarro: UIImageView!
    
    @IBOutlet weak var saidaConsumo: UILabel!
    
    @IBOutlet weak var entradaKmRodados: UITextField!
    
    @IBOutlet weak var entradaAutonomia: UITextField!
    
    @IBAction func compartilhar(_ sender: Any) {
        
        saidaConsumo.text = " Consumo Atual: \n\n" + "Usuário 01 = " + String(format: "%.2f", (UserDefaults.standard.object(forKey: "consumo0") as? Float ?? 0.0)) + " litros \n" + "Usuário 02 = " + String(format: "%.2f", (UserDefaults.standard.object(forKey: "consumo1") as? Float ?? 0.0)) + " litros"
        shareResult()
    }
    
    @IBAction func deletaTudo(_ sender: Any) {
        consumoUser[0] = 0.0
        
        UserDefaults.standard.set(consumoUser[0], forKey: "consumo0")
        
        consumoUser[1] = 0.0
        
        UserDefaults.standard.set(consumoUser[1], forKey: "consumo1")
        
        testeImagem()
    }
    
    func lerKm() {
        // funcao para ler quantidade de Km rodados pelo usuario
        self.km = entradaKmRodados.text ?? "0"
    }
    func lerAutonomia() {
        // funcao para ler qual a autonomia do veiculo em Km/l
        self.autonomia = entradaAutonomia.text ?? "0"
    }
    
    @IBAction func clicarNoBotaoAdd(_ sender: Any) {
        lerKm()
        lerAutonomia()
        calcularConsumo()
        testeImagem()
        
    }
    
    func calcularConsumo() {
        // funcao para calcular a quantidade de litros consumida pelo usuario atraves da formula: Km rodados / autonomia do veiculo
        
        let kmFloat: Float
        kmFloat = Float(km)!
                
        let autonomiaFloat: Float
        autonomiaFloat = Float(autonomia)!
        
        let travel: Corrida
        travel = Corrida(user: userX.selectedSegmentIndex, km: kmFloat, autonomia: autonomiaFloat)
        
        var consumo: Float
        consumo = travel.calculaConsumo()
        
        if travel.user == 0 {
            consumoUser[0] = consumoUser[0] + consumo
            UserDefaults.standard.set(consumoUser[0], forKey: "consumo0")
        }
        
        if travel.user == 1 {
            consumoUser[1] = consumoUser[1] + consumo
            UserDefaults.standard.set(consumoUser[1], forKey: "consumo1")
        }

        print("O consumo foi: ", consumo)
    }
    
    func shareResult() {
        let shareText = [ saidaConsumo.text ]
        let activityViewController = UIActivityViewController(activityItems: shareText as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func testeImagem() {
        // funcao para apagar a imagem do carro na tela
        if consumoUser[0] > 0.0 || consumoUser[1] > 0.0{
           self.imagemCarro.isHidden = true
            self.saidaConsumo.isHidden = false
            saidaConsumo.text = " Consumo Atual: \n\n" + "Usuário 01 = " + String(format: "%.2f", (UserDefaults.standard.object(forKey: "consumo0") as? Float ?? 0.0)) + " litros \n" + "Usuário 02 = " + String(format: "%.2f", (UserDefaults.standard.object(forKey: "consumo1") as? Float ?? 0.0)) + " litros"
        }
        else{
            self.imagemCarro.isHidden = false
            self.saidaConsumo.isHidden = true
        }
    }
}

