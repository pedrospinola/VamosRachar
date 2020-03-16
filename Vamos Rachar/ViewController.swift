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
    var consumoUser: [Float] = [0.0,0.0]
    let user: [String] = ["Usuário 01", "Usuário 02"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBOutlet weak var userX: UISegmentedControl!
    
    @IBOutlet weak var imagemCarro: UIImageView!
    
    @IBOutlet weak var saidaConsumo: UILabel!
    
    @IBOutlet weak var entradaKmRodados: UITextField!
    
    @IBOutlet weak var entradaAutonomia: UITextField!
    
    
    func lerUsuario() {
        // funcao para ler qual usuario foi selecionado no picker
    }
    func lerKm() {
        // funcao para ler quantidade de Km rodados pelo usuario
        self.km = entradaKmRodados.text!
    }
    func lerAutonomia() {
        // funcao para ler qual a autonomia do veiculo em Km/l
        self.autonomia = entradaAutonomia.text!
    }
    
    @IBAction func clicarNoBotaoAdd(_ sender: Any) {
        lerUsuario()
        lerKm()
        lerAutonomia()
        calcularConsumo()
        apagaImagem()
        
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
        }
        
        if travel.user == 1 {
            consumoUser[1] = consumoUser[1] + consumo
        }
        
        self.saidaConsumo.isHidden = false
        saidaConsumo.text = " Consumo Atual: \n\n" + "Usuário 01 = " + String(format: "%.2f", consumoUser[0]) + " litros \n" + "Usuário 02 = " + String(format: "%.2f", consumoUser[1]) + " litros"

        
        print("O consumo foi: ", consumo)
    }
    
    func apagaImagem() {
        // funcao para apagar a imagem do carro na tela
        self.imagemCarro.isHidden = true
    }

}

