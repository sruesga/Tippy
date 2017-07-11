//
//  ViewController.swift
//  Tippy
//
//  Created by Skyler Ruesga on 6/20/17.
//  Copyright © 2017 Skyler Ruesga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISlider!
    @IBOutlet weak var tipPercentage: UILabel!
    
    let defaults = UserDefaults.standard
    var tipAmount: Float = 0.15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if defaults.object(forKey: "default_tip_percentage") != nil {
            tipAmount = defaults.float(forKey: "default_tip_percentage")
            print(tipAmount)
        }
        tipControl.setValue(tipAmount, animated: true)
        tipPercentage.text = String(format: "%.2f%%", tipAmount * 100)
        defaults.set(tipAmount, forKey: "default_tip_percentage")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Float(billField.text!) ?? 0
        let tip = bill * tipAmount
        let total = bill + tip
        
        tipPercentage.text = String(format: "%.2f%%", tipAmount * 100)
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func sliderDidMove(_ sender: UISlider) {
        tipAmount = sender.value
        tipPercentage.text = String(tipAmount * 100) + "%"
        calculateTip(self)
    }
    
    @IBAction func setDefault(_ sender: Any) {
        defaults.set(tipAmount, forKey: "default_tip_percentage")
        defaults.synchronize()
    }
}

