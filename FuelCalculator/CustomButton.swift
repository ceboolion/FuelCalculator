//
//  CustomButton.swift
//  FuelCalculator
//
//  Created by Roman Cebula on 08/03/2019.
//  Copyright © 2019 Roman Cebula. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect){
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setUpButton()
    }

    func setUpButton() {
        buttonDesign()
        shakeButton()
    }
    
    func buttonDesign() {
        backgroundColor     = .white
        layer.cornerRadius  = frame.size.height/2
        layer.shadowRadius  = 8
        layer.shadowColor   = UIColor.white.cgColor
        layer.shadowOpacity = 0.5
        
    }
    
    func shakeButton() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint = CGPoint(x: center.x - 8, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 8, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
        
    }
}
