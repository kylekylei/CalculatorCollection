//
//  WeightViewController.swift
//  CalculatorCollection
//
//  Created by Kyle Lei on 2021/9/19.
//

import UIKit
import Foundation

class WeightViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var inputUnitField: UITextField!
    @IBOutlet weak var outputUnitField: UITextField!
    
    let fullScreenSize = UIScreen.main.bounds
    let massUnitSymbol = ["kg","g","cg","mg","ng","pg","oz","lb","ct"]
    let massUnitName = ["Kilograms","Grams","Centigrams","Milligrams","Nanograms","Picograms","Ounces","Pounds","Carats"]

   
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
        
         
        inputUnit = massUnitSymbol[1]
        outputUnit = massUnitSymbol[7]
        
        inputUnitField.text = inputUnit
        outputUnitField.text = outputUnit
           
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return massUnitSymbol.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return massUnitName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if inputUnitField.isEditing {
            inputUnitField.text = massUnitSymbol[row]
            inputUnit = massUnitSymbol[row]
        }else {
            outputUnitField.text = massUnitSymbol[row]
            outputUnit = massUnitSymbol[row]
        }
                
    }
    
    func calculate() {
        
        let inputText = inputField.text!
        let input = Double(inputText) ?? 0.0
        
        
        func unitMass(unitSource: String) -> UnitMass {
            var unitLength: UnitMass
            switch unitSource {
                case "kg": unitLength = UnitMass.kilograms
                case "g": unitLength = UnitMass.grams
                case "cg": unitLength = UnitMass.centigrams
                case "mg": unitLength = UnitMass.milligrams
                case "ng": unitLength = UnitMass.nanograms
                case "pg": unitLength = UnitMass.picograms
                case "oz": unitLength = UnitMass.ounces
                case "lb": unitLength = UnitMass.pounds
                default: unitLength = UnitMass.carats
            }
            return unitLength
        }
    
    
        let inputUnit = Measurement(value: input, unit: unitMass(unitSource: inputUnit))
        
        let outputUnit = inputUnit.converted(to: unitMass(unitSource: outputUnit))
        
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
