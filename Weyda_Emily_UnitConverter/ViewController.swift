//
//  ViewController.swift
//  Weyda_Emily_UnitConverter
//
//  Created by Emily Weyda on 6/15/16.
//  Copyright © 2016 University of Cincinnati. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    var units : NSDictionary!
    var unitNames : NSArray!
    
    @IBOutlet weak var textAmount: UITextField!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var pvUnitFrom: UIPickerView!
    @IBOutlet weak var pvUnitTo: UIPickerView!
    
    @IBAction func convertUnits() {
        // 1. retrieve user input
        // 1.1. amount
        let amountAsString = textAmount.text!
        // 1.1.1. convert the amount from a string to a number
        let numberFormatter = NSNumberFormatter()
        let amountAsNumber = numberFormatter.numberFromString(amountAsString)!
        let amount = amountAsNumber.floatValue
        // 1.2. unit from
        let indexFrom = pvUnitFrom.selectedRowInComponent(0)
        let unitFrom = unitNames.objectAtIndex(indexFrom) as! String
        // 1.3. unit to
        let indexTo = pvUnitTo.selectedRowInComponent(0)
        let unitTo = unitNames.objectAtIndex(indexTo) as! String
        // 2. apply the two step conversion
        // 2.1. convert from unit from to inches
        let conversionFactorToInches = units.valueForKey(unitFrom) as! Float
        let resultAsInches = amount * conversionFactorToInches
        // 2.2. convert from inches to the unit to
        let conversionFactorFromInches = units.valueForKey(unitTo) as! Float
        let result = resultAsInches/conversionFactorFromInches
        // 3. display the results
        let resultAsString = String.localizedStringWithFormat("%.2f %@ = %.2f %@",amount,unitFrom,result,unitTo)
        labelResult.text = resultAsString
        // 4. dismiss the keyboard
        textAmount.resignFirstResponder()
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        convertUnits()
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        // 1. get a reference from app bundle
        let appBundle = NSBundle.mainBundle()
        // 2. get a reference to the unitsList file
        let filePath = appBundle.pathForResource("unitsList", ofType: "plist")!
        // 3. load the contents of the file to the dictionary
        units = NSDictionary(contentsOfFile: filePath)!
        // 4. retrieve the unit names into the array
        unitNames = units.allKeys
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return unitNames.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unitNames.objectAtIndex(row) as! String
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        convertUnits()
        return true
    }

}

 