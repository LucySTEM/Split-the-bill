//
//  ViewController.swift
//  SplitTheBill
//
//  Created by Lucy on 13/08/2020.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPrcButton: UIButton!
    @IBOutlet weak var fivePrcButton: UIButton!
    @IBOutlet weak var tenPrcButton: UIButton!
    @IBOutlet weak var fifteenPrcButton: UIButton!
    @IBOutlet weak var twentyPrcButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.0
    var splitNumber = 2
    var billTotal = 0.0
    var finalResult = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        //the keyboard will be hiden after clicking on the tip
        billTextField.endEditing(true)
        
        zeroPrcButton.isSelected = false
        fivePrcButton.isSelected = false
        tenPrcButton.isSelected = false
        fifteenPrcButton.isSelected = false
        twentyPrcButton.isSelected = false
        sender.isSelected = true
    
    //storing current title of the button, f.e. 0%, 5%, 10% ...
    let buttonTitle = sender.currentTitle!
        
    //removing % sign from the button title, so instead of "5%" is stored value "5" and making it String
    let buttonTitleWithoutPercentSign =  String(buttonTitle.dropLast())
    
    // turning String to Double
    let buttonTitleBeNumber = Double(buttonTitleWithoutPercentSign)!
    
    // number changed to decimal, f.e. 5 to 0.05
    tip = buttonTitleBeNumber / 100
    }
    
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        sender.minimumValue = 2
        splitNumberLabel.text = Int(sender.value).description
        splitNumber = Int(sender.value)
    }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let bill = billTextField.text!
        
        // if text is not empty String then
        if bill != "" {

            //change the String to String with decimal (double)
            billTotal = Double(bill)!

            //billTotal + tip / splitNumber
            let result = billTotal * (1 + tip) / Double(splitNumber)

            //result = 2 decimals, changing for String
            let resultToDecimals = String(format: "%.2f", result)
            
            finalResult = String(format: "%.2f", result)
        
        print(resultToDecimals)
            
            //switch the screen
            self.performSegue(withIdentifier: "switchToResult", sender: self)
        }
    }
    
    //if the segue is perform (switching the screen)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //If segue is "switchToResult".
        if segue.identifier == "switchToResult" {

            //a reference to this new viewController called "destinationVC" and change from UIViewController to ResultsViewController with "as!"
            let destinationVC = segue.destination as! ResultsViewController

            //ResultsViewController's properties.
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = splitNumber
        }
    }

}

