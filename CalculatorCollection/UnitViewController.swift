//
//  UnitViewController.swift
//  CalculatorCollection
//
//  Created by Kyle Lei on 2021/9/16.
//

import UIKit
import Foundation

class UnitViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var inputUnitField: UITextField!
    @IBOutlet weak var outputUnitField: UITextField!
    
    let fullScreenSize = UIScreen.main.bounds
    let lengthUnitSymbol = ["km","m","cm","mm","mi","nm","yd","in","ft"]
    let lengthUnitName = ["Kilometers","Meters","Centimeters","Millimeters","Miles","Nautical Miles","Yards","Inches","Feet"]

   
    var inputUnit = ""
    var outputUnit = ""
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var outputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

              
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        inputUnitField.inputView = pickerView
        outputUnitField.inputView = pickerView
        
         
        inputUnit = lengthUnitSymbol[1]
        outputUnit = lengthUnitSymbol[7]
        
        inputUnitField.text = inputUnit
        outputUnitField.text = outputUnit
           
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lengthUnitSymbol.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lengthUnitName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if inputUnitField.isEditing {
            inputUnitField.text = lengthUnitSymbol[row]
            inputUnit = lengthUnitSymbol[row]
        }else {
            outputUnitField.text = lengthUnitSymbol[row]
            outputUnit = lengthUnitSymbol[row]
        }
                
    }
    
    func calculate() {
        
        let inputText = inputField.text!
        let input = Double(inputText) ?? 0.0
        
        
        func unitLength(unitSource: String) -> UnitLength {
            var unitLength: UnitLength
            switch unitSource {
                case "km": unitLength = UnitLength.kilometers
                case "m": unitLength = UnitLength.meters
                case "mm": unitLength = UnitLength.millimeters
                case "mi": unitLength = UnitLength.miles
                case "nm": unitLength = UnitLength.nauticalMiles
                case "yd": unitLength = UnitLength.yards
                case "in": unitLength = UnitLength.inches
                case "ft": unitLength = UnitLength.feet
                default: unitLength = UnitLength.centimeters
            }
            return unitLength
        }
    
        let inputUnit = Measurement(value: input, unit: unitLength(unitSource: inputUnit))
        
        let outputUnit = inputUnit.converted(to: unitLength(unitSource: outputUnit))
        
        let outputText = outputUnit.value
        outputField.text = String(format: "%.2f", outputText)
        
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        calculate()
   }
    
    
    @IBAction func cleanValue(_ sender: UIButton) {
        inputField.text = ""
        outputField.text = ""
    }
    
    @IBAction func endEdit(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}
