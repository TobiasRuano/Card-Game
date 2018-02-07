//
//  GradientView.swift
//  Card Game
//
//  Created by Tobias Ruano on 10/1/18.
//  Copyright © 2018 Tobias Ruano. All rights reserved.
//

import UIKit

@IBDesignable

class GradientView: UIView {
    
    @IBInspectable var FirstColor: UIColor = UIColor.clear {
        didSet{
            updateView()
        }
    }
    
    @IBInspectable var SecondColor: UIColor = UIColor.clear{
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor, SecondColor.cgColor]
    }
    
}
