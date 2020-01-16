//  Created by Roman Cebula on 27/01/2019.
//  Copyright © 2019 Roman Cebula. All rights reserved.

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
  
  var calculateButtonDesign = CustomButton()
  
  @IBOutlet var calculateButton: UIButton!
  @IBOutlet var distanceInKmTextField: UITextField!
  @IBOutlet var fuelPriceTextField: UITextField!
  @IBOutlet var fuelConsumptionTextField: UITextField!
  @IBOutlet var errorMessageLabel: UILabel!
  
  private var kilometersValue: Double?
  private var fuelPrice: Double?
  private var fuelConsumption: Double = 5.0
  private var calculations: Double?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    distanceInKmTextField.delegate = self
    fuelPriceTextField.delegate = self
    fuelConsumptionTextField.delegate = self
    fuelConsumptionTextField.text = String(fuelConsumption)
//    fuelConsumptionTextField.
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
  
  private func calculateTrip() {
    kilometersValue = Double(distanceInKmTextField.text!)
    fuelPrice = Double(fuelPriceTextField.text!)
//    fuelConsumption = Double(fuelConsumptionTextField.text!)
    
    if kilometersValue == nil || fuelPrice == nil {
      errorMessageLabel.text = "Fill all required fields"
    } else {
      errorMessageLabel.text = ""
      calculations = ((kilometersValue! * fuelConsumption) / 100) * fuelPrice!
      performSegue(withIdentifier: "nextScreen", sender: self)
      print("Ilość litrów potrzebnych na wycieczkę to: " + String(format:"%.2f", calculations!) + " zł")
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "nextScreen" {
      let resultVC = segue.destination as! ResultViewController
      resultVC.data = "The amount of travel is: " + String(format:"%.2f", calculations!) + " zł"
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    distanceInKmTextField.resignFirstResponder()
    fuelPriceTextField.resignFirstResponder()
    fuelConsumptionTextField.resignFirstResponder()
    return true
  }
  
  // Clear all fields
  private func clearAllFileds() {
    distanceInKmTextField.text = ""
    fuelPriceTextField.text = ""
    fuelConsumptionTextField.text = String(fuelConsumption)
    errorMessageLabel.text = ""
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
    var allowedCharacters = "0123456789.,"
    if (textField.text?.contains("."))! {
      allowedCharacters = "0123456789"
    } else {
      allowedCharacters = "0123456789.,"
    }
    let allowedCaracterSet = CharacterSet(charactersIn: allowedCharacters)
    let typedCharactersSet = CharacterSet(charactersIn: string)
    return allowedCaracterSet.isSuperset(of: typedCharactersSet)
  }
  
  @IBAction func fuelConsumptionDataPressed(_ sender: UIButton) {
      if sender.tag == 1{
        fuelConsumption -= 0.5
        fuelConsumptionTextField.text = String(fuelConsumption)
        if fuelConsumption < 0.0 {
          fuelConsumption = 0.0
        }
      } else {
        fuelConsumption += 0.5
        fuelConsumptionTextField.text = String(fuelConsumption)
      }
   
    
//    if sender.tag == 1{
//        fuelConsumption -= 0.5
//        fuelConsumptionTextField.text = String(fuelConsumption)
//      } else {
//        fuelConsumption += 0.5
//        fuelConsumptionTextField.text = String(fuelConsumption)
//      }
    
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
