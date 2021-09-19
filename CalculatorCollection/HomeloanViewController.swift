//
//  HomeloanViewController.swift
//  CalculatorCollection
//
//  Created by Kyle Lei on 2021/9/19.
//

import UIKit

class HomeloanViewController: UIViewController {
    
    @IBOutlet weak var loanamountField: UITextField!
    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var perLoanLabel: UILabel!
    @IBOutlet weak var rateField: UITextField!
    @IBOutlet weak var promptLable: UILabel!
    @IBOutlet weak var loanView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func calculate(_ sender: UIButton) {
        
        
        let loanamountText = loanamountField.text!
        let yearText = yearField.text!
        let rateText = rateField.text!
        let loanamount = Double(loanamountText)
        let year = Double(yearText)
        let rate = Double(rateText)
      
        var apiRate: Double = 0
        var api: Double = 0
        var CompoundInterest: Double = 1
        if loanamount != nil && year != nil && rate != nil {
            let monthRate = rate! / 12 / 100
            let month = year! * 12
            
            
            for _ in 1...Int(month) {
                CompoundInterest *= (1 + monthRate )
            }
            apiRate = (CompoundInterest * monthRate) / (CompoundInterest - 1)
            api = loanamount! * apiRate * 10000
            
            let apiNSNumber = NSNumber(value: api)
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.usesGroupingSeparator = true
            numberFormatter.maximumFractionDigits = 0
            
            let apiNumber = numberFormatter.string(from: apiNSNumber)
            
            perLoanLabel.text = apiNumber
        }
        
        
        if api != 0 {
            loanView.isHidden = false
        } else {
            promptLable.text = "還沒輸入資料"
        }
        
   }
    
    @IBAction func cleanValue(_ sender: UIButton) {
        loanamountField.text = ""
        yearField.text = ""
        perLoanLabel.text = ""
        rateField.text = ""
        loanView.isHidden = true
    }
    
    @IBAction func endEdit(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

