//
//  ViewController.swift
//  FuelCalculator
//
//  Created by Roman Cebula on 27/01/2019.
//  Copyright © 2019 Roman Cebula. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var calculateButtonDesign = CustomButton()
    
 
    
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var kilometersValue: UITextField!
    @IBOutlet weak var fuelPrice: UITextField!
    @IBOutlet weak var fuelConsumption: UITextField!
    @IBOutlet weak var result: UILabel!
    
       
    
    var selectedFuelConsumption: Double?
    var kilometersValueField: Double?
    var fuelPriceField: Double?
    var fuelConsumptionField: Double?
    
    var calculations: Double?
    var finalAmount: Double?
    var finalInformation: String?
    var finalResult: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        kilometersValue.delegate = self
        fuelPrice.delegate = self
        fuelConsumption.delegate = self
        shakeButton()
        self.hideKeyboard()
        
    }
    
    
   
    
    
    @IBAction func clearAllFields(_ sender: UIButton) {
        clearAllFileds()
        
    }
    

    @IBAction func calculatePressed(_ sender: CustomButton) {
               
        calculateTrip()
        shakeButton()
        
    }
    
    func calculateTrip() {
        kilometersValueField = Double(kilometersValue.text!)
        fuelPriceField = Double(fuelPrice.text!)
        fuelConsumptionField = Double(fuelConsumption.text!)
                
        if kilometersValueField == nil || fuelPriceField == nil || fuelConsumptionField == nil {
            finalResult = "Fill all required fields"
            result.text = finalResult
        } else {
            
            result.text = nil
            calculations = (kilometersValueField! * fuelConsumptionField!) / 100
            finalAmount = calculations! * fuelPriceField!
            finalInformation = "The amount of travel is: " + String(format:"%.2f", finalAmount!) + " zł"
            performSegue(withIdentifier: "nextScreen", sender: self)
            print("Ilość litrów potrzebnych na wycieczkę to: " + finalInformation!)
        
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextScreen" {
            let resultVC = segue.destination as! ResultViewController
            resultVC.data = finalInformation
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        kilometersValue.resignFirstResponder()
        fuelPrice.resignFirstResponder()
        fuelConsumption.resignFirstResponder()
        return true
    }
    
    
    
    
    
    // Clear all fields
    func clearAllFileds() {
        kilometersValue.text = nil
        fuelPrice.text = nil
        fuelConsumption.text = nil
        finalInformation = nil
        
    }
    
    // Addition of a shake to the button
    
    func shakeButton() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration      = 0.1
        shake.repeatCount   = 2
        shake.autoreverses  = true
        
        let fromPoint = CGPoint(x: calculateButton.center.x - 8, y: calculateButton.center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: calculateButton.center.x + 8, y: calculateButton.center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        calculateButton.layer.add(shake, forKey: "position")
        
    }
    
    
    
    // Function that validates UITEXTFIELD
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
       
        
        let allowedCharacters = "0123456789.,"
        let allowedCaracterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharactersSet = CharacterSet(charactersIn: string)
        return allowedCaracterSet.isSuperset(of: typedCharactersSet)
        
    }
    
    @IBAction func goToMapPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToMap", sender: self)
        
    }
    
    

}

extension UIViewController{
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
