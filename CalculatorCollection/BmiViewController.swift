//
//  BmiViewController.swift
//  BmiViewController
//
//  Created by Kyle Lei on 2021/9/15.
//

import UIKit

class BmiViewController: UIViewController {

    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var bmiValueLabel: UILabel!
    @IBOutlet weak var suggestionLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func calculate(_ sender: UIButton) {
        
        
        let weightText = weightField.text!
        let heightText = heightField.text!
        let weight = Double(weightText)
        let height = Double(heightText)
      
        var bmi: Double = 0
        if weight != nil && height != nil {
            let heightMeter = height! / 100
            bmi = weight! / (heightMeter * heightMeter)
            bmiValueLabel.text = String(format: "%.2f", bmi)
        }
        
        
        var bmiDefinition = ""
        
        if bmi != 0 {
            switch bmi {
            case ..<18.5 : bmiDefinition = "體重過輕"
            case 18.5..<24 : bmiDefinition = "健康體位"
            case 24..<27 : bmiDefinition = "過重"
            case 27..<30 : bmiDefinition = "輕度肥胖"
            case 30..<35 : bmiDefinition = "中度肥胖"
            default:
                bmiDefinition = "重度肥胖"
            }
            suggestionLabel.text = bmiDefinition
            bmiLabel.isHidden = false
        } else {
            suggestionLabel.text = "還沒輸入資料"
        }
        
   }
    
    @IBAction func cleanValue(_ sender: UIButton) {
        weightField.text = ""
        heightField.text = ""
        bmiValueLabel.text = ""
        suggestionLabel.text = ""
        bmiLabel.isHidden = true
    }
    
    @IBAction func endEdit(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func emptyInfo(_ sender: UITextField) {
        suggestionLabel.text = ""
    }
    
}
