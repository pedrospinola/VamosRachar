//
//  Classe Corrida.swift
//  Vamos Rachar
//
//  Created by Pedro Henrique Spínola de Assis on 10/03/20.
//  Copyright © 2020 Pedro Henrique Spínola de Assis. All rights reserved.
//

class Corrida {
    var user: Int
    var km: Float
    var autonomia: Float

    init (user: Int, km: Float, autonomia: Float){
        self.user = user
        self.km = km
        self.autonomia = autonomia
    }
    func calculaConsumo () -> Float{
        var consumo: Float
        consumo = Float(km / autonomia)
        
        return consumo
    }
}
