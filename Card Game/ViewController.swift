//
//  ViewController.swift
//  Card Game
//
//  Created by Tobias Ruano on 29/7/17.
//  Copyright © 2017 Tobias Ruano. All rights reserved.
//

import UIKit

var totalCpu = 0
var totalUser = 0
var datoObtenidoCpu = 0
var datoObtenidoPlayer = 0

class ViewController: UIViewController {
    
    var nombre = ""
    
    @IBAction func reset(_ sender: UIButton) {
        
        (totalCpu, totalUser) = resetScore()
        leftImageView.image = UIImage(named: back)
        rightImageView.image = UIImage(named: back)
        (playerScore, cpuScore) = resetScore()
        playerScoreLable.text = String(playerScore)
        cpuScoreLabel.text = String(cpuScore)
        
        createAlert(tittle: "Reseted!!!", message: "Come on! Let's play again!!")
    }
    
    var flag = true
    
    @IBOutlet weak var higherButton: UIButton!
    
    @IBAction func higher(_ sender: UIButton) {
        
//        if playerScore == 0  &&  cpuScore == 0 {
//            rightImageView.image = UIImage(named: "back")
//            leftImageView.image = UIImage(named: "back")
//        }
        
        let rightNumber = Int(arc4random_uniform(13))
        leftImageView.image = UIImage(named: cardName[rightNumber])
        
        let leftNumber = Int(arc4random_uniform(13))
        rightImageView.image = UIImage(named: cardName[leftNumber])
        
        if leftNumber > rightNumber {
            playerScore += 1
            playerScoreLable.text = String(playerScore)
        }else if leftNumber == rightNumber {
            
        }else {
            cpuScore += 1
            cpuScoreLabel.text = String(cpuScore)
        }
        
        (playerScore, cpuScore, flag) = winner(left: playerScore, right: cpuScore, boolean: flag)
        if playerScore == 0 && cpuScore == 0 {
            playerScoreLable.text = String(playerScore)
            cpuScoreLabel.text = String(cpuScore)
            if flag == true {
                totalUser = totalUser + 1
                createAlert(tittle: "You Win!!", message: "\(nombre): \(totalUser) -- CPU: \(totalCpu) ")
            }else {
                totalCpu = totalCpu + 1
                createAlert(tittle: "You Lose", message: "\(nombre): \(totalUser) -- CPU: \(totalCpu) ")
            }
        }
        UserDefaults.standard.set(totalUser, forKey: "PlayerScore")
        UserDefaults.standard.set(totalCpu, forKey: "CpuScore")
    }
    
    @IBOutlet weak var lowerButton: UIButton!
    
    @IBAction func lower(_ sender: UIButton) {
        
//        if playerScore == 0  &&  cpuScore == 0 {
//            rightImageView.image = UIImage(named: "back")
//            leftImageView.image = UIImage(named: "back")
//        }
        
        let rightNumber = Int(arc4random_uniform(13))
        leftImageView.image = UIImage(named: cardName[rightNumber])
        
        let leftNumber = Int(arc4random_uniform(13))
        rightImageView.image = UIImage(named: cardName[leftNumber])
        
        if leftNumber < rightNumber {
            playerScore += 1
            playerScoreLable.text = String(playerScore)
        }else if leftNumber == rightNumber {
            
        }else {
            cpuScore += 1
            cpuScoreLabel.text = String(cpuScore)
        }
        
        (playerScore, cpuScore, flag) = winner(left: playerScore, right: cpuScore, boolean: flag)
        if playerScore == 0 && cpuScore == 0 {
            playerScoreLable.text = String(playerScore)
            cpuScoreLabel.text = String(cpuScore)
            if flag == true {
                totalUser = totalUser + 1
                createAlert(tittle: "You Win!!", message: "\(nombre): \(totalUser) -- CPU: \(totalCpu) ")
            }else {
                totalCpu = totalCpu + 1
                createAlert(tittle: "You Lose", message: "\(nombre): \(totalUser) -- CPU: \(totalCpu) ")
            }
        }
        UserDefaults.standard.set(totalUser, forKey: "PlayerScore")
        UserDefaults.standard.set(totalCpu, forKey: "CpuScore")
    }
    
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var playerScoreLable: UILabel!
    var playerScore = 0
    @IBOutlet weak var cpuScoreLabel: UILabel!
    @IBOutlet weak var PlayerName: UILabel!
    var cpuScore = 0
    @IBOutlet weak var logo: UIImageView!
    
    
    let cardName = ["ace", "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king"]
    let back = "back"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (playerScore, cpuScore) = resetScore()
        buttonStyle(boton: higherButton)
        buttonStyle(boton: lowerButton)
        imageViewStyle(image: leftImageView)
        imageViewStyle(image: rightImageView)
        imageViewStyle(image: logo)
    }
    
    func imageViewStyle(image: AnyObject) {
        image.layer.shadowRadius = 6
        image.layer.shadowOpacity = 1
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    func buttonStyle(boton: UIButton){
        boton.backgroundColor = UIColor.white
        boton.layer.cornerRadius = boton.frame.height / 2
        boton.setTitleColor(UIColor.black, for: .normal)
        boton.layer.shadowColor = UIColor.darkGray.cgColor
        boton.layer.shadowRadius = 10
        boton.layer.shadowOpacity = 10
        boton.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (UserDefaults.standard.value(forKey: "name") as? String) == nil {
            nombre = usuario()
            PlayerName.text = nombre
        }else{
            print("User Defaults else \(UserDefaults.standard.value(forKey: "name") as! String)")
            nombre = UserDefaults.standard.string(forKey: "name")!
            PlayerName.text = nombre
        }
    }

    
    func winner(left: Int, right: Int, boolean: Bool) -> (Int, Int, Bool){
        
        var flag = boolean
        var leftNumber=left
        var rightNumber=right
        
        if left==10{
            print("USER WINS!")
            //Taptic feedback
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            flag = true
            (leftNumber, rightNumber) = resetScore()
        }else if right==10 {
            print("USER LOSE!")
            //Taptic feedback
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            flag = false
            (leftNumber, rightNumber) = resetScore()
        }else {
        }
        return(leftNumber, rightNumber, flag)
    }
    
    func resetScore() -> (Int, Int){
        let left = 0
        let right = 0
        return (left, right)
    }
    
    func createAlert(tittle: String, message: String){
        
        let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            
            self.leftImageView.image = UIImage(named: self.back)
            self.rightImageView.image = UIImage(named: self.back)
        }))
        
        self.present(alert, animated:  true, completion: nil)
    }
    
    func usuario() -> String {
        var tField: UITextField!
        
        func configurationTextField(textField: UITextField!)
        {
            print("generating the TextField")
            textField.placeholder = "Enter an item"
            textField.textAlignment = .center
            tField = textField
        }
        
        func handleCancel(alertView: UIAlertAction!)
        {
            print("Cancelled !!")
        }
        
        let alert = UIAlertController(title: "Please Enter Your Name", message: "", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler:{ (UIAlertAction) in
            print("Done !!")
            
            print("Item : \(String(describing: tField.text))")
            self.nombre = tField.text!
            self.PlayerName.text = self.nombre
            
            //Guardo el nombre
            UserDefaults.standard.set(self.nombre, forKey: "name")
            
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        print(self.nombre)
        
        if tField.text == nil {
            return "No value"
        }else{
            return (tField.text!)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let aboutViewController = segue.destination as? AboutViewController {
            aboutViewController.nombrepasado = nombre
        }
    }
    
    @IBAction func info(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
}
