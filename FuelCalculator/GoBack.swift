//
//  GoBack.swift
//  FuelCalculator
//
//  Created by Roman Cebula on 13/03/2019.
//  Copyright © 2019 Roman Cebula. All rights reserved.
//

import UIKit

class GoBack: UIButton {

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
       
    }
    
    func buttonDesign() {
        backgroundColor     = .darkGray
        layer.cornerRadius  = frame.size.height/2
        layer.shadowRadius  = 8
        layer.shadowColor   = UIColor.white.cgColor
        layer.shadowOpacity = 0.9
        
    }

}
