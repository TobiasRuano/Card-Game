//
//  CustomButton.swift
//  Card Game
//
//  Created by Tobias Ruano on 12/1/18.
//  Copyright © 2018 Tobias Ruano. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
        }
    }


}

