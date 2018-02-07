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
    
    var nombrepasado:String = "Player"
    
    @IBOutlet weak var infoLabel: UILabel!
    
    
    @IBAction func doneTapped(_ sender: Any) {
        print(totalUser)
        self.dismiss(animated: true, completion: nil)
    }
    
    func porcentaje(usuario: Int , cpu: Int) -> (String, String){
        var pSUsuario: String
        var pSCpu: String
        if (usuario == 0 && cpu == 0) == true {
            pSCpu = "50%"
            pSUsuario = "50%"
        }else{
            let porcentajeUsuario = (usuario * 100) / (usuario + cpu)
            let porcentajeCpu = (cpu * 100) / (usuario + cpu)
            pSUsuario = porcentajeUsuario.description + "%"
            pSCpu = porcentajeCpu.description + "%"
        }
        return (pSUsuario, pSCpu)
    }
    
    @IBOutlet weak var labelPlayer: UILabel!
    @IBOutlet weak var labelCpu: UILabel!
    @IBOutlet weak var porcentajeUsuario: UILabel!
    @IBOutlet weak var porcentajeCpu: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playerName.text = nombrepasado
        print("El nombre pasado es: \(nombrepasado)")
        labelPlayer.text = String(totalUser)
        labelCpu.text = String(totalCpu)
        
        (porcentajeUsuario.text! , porcentajeCpu.text!) = porcentaje(usuario: totalUser, cpu: totalCpu)
    }
    @IBOutlet weak var playerName: UILabel!
    
}
