//
//  AboutViewController.swift
//  Card Game
//
//  Created by Tobias Ruano on 13/9/17.
//  Copyright © 2017 Tobias Ruano. All rights reserved.
//

import Foundation
import UIKit


class AboutViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var labelPlayer: UILabel!
    @IBOutlet weak var labelCpu: UILabel!
    @IBOutlet weak var porcentajeUsuario: UILabel!
    @IBOutlet weak var porcentajeCpu: UILabel!
    
    var nombrepasado: String = "Player"
    var totalCpu = 0
    var totalUser = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveScores()
        playerName.text = nombrepasado
        print("El nombre pasado es: \(nombrepasado)")
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        labelPlayer.text = String(totalUser)
        labelCpu.text = String(totalCpu)
        
        (porcentajeUsuario.text! , porcentajeCpu.text!) = porcentaje(usuario: Float(totalUser), cpu: Float(totalCpu))
    }
    
    func retrieveScores() {
        if UserDefaults.standard.value(forKey: "CpuScore") != nil {
            totalCpu = UserDefaults.standard.value(forKey: "CpuScore") as! Int
            print("El puntaje obtenido del cpu fue \(totalCpu)")
        }
        if UserDefaults.standard.value(forKey: "PlayerScore") != nil {
            totalUser = UserDefaults.standard.value(forKey: "PlayerScore") as! Int
            print("El puntaje obtenido del jugador fue \(totalUser)")
        }
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        print(totalUser)
        self.dismiss(animated: true, completion: nil)
    }
    
    func porcentaje(usuario: Float , cpu: Float) -> (String, String){
        var pSUsuario: String
        var pSCpu: String
        if (usuario == 0 && cpu == 0) == true {
            pSCpu = "50%"
            pSUsuario = "50%"
        }else{
            let porcentajeUsuario: Float = (usuario * 100) / (usuario + cpu)
            let porcentajeCpu: Float = (cpu * 100) / (usuario + cpu)
            pSUsuario = (String(format: "%.1f", porcentajeUsuario)) + "%"
            pSCpu = (String(format: "%.1f", porcentajeCpu)) + "%"
        }
        return (pSUsuario, pSCpu)
    }
}
