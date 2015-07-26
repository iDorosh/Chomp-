//
//  NewIngredient.swift
//  Chomp!
//
//  Created by Ian Dorosh on 7/24/15.
//  Copyright (c) 2015 Ian Dorosh. All rights reserved.
//

import UIKit

class NewIngredient: UIViewController {
    
    var units: [String] = ["none","lb","oz","pt","fl oz","cup","tsp","tbsp"]
    var singleIngredient : [String] = [String]()
    var value : Int = 0
    var selected : Int = 0
    
    @IBOutlet weak var ingredientName: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var measurement: UITextField!
    @IBOutlet weak var conversion: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    
    @IBAction func openPicker(sender: UIButton)
    {
        picker.hidden = false
        cancel.hidden = false
        done.hidden = false
        selected = 1
    }
    
    @IBAction func openPickerConvert(sender: UIButton)
    {
        picker.hidden = false
        cancel.hidden = false
        done.hidden = false
        selected = 0
    }
    @IBAction func saveMeasurment(sender: UIButton)
    {
        done.hidden = true
        cancel.hidden = true
        if (selected == 1)
        {
            measurement.text = units[value]
        }
        else
        {
            conversion.text = units[value]
        }
        
        if (measurement.text == "" || measurement.text == "none")
        {
            conversion.text = "none"
        }
        picker.hidden = true
    }
    
    @IBAction func closePicker(sender: UIButton)
    {
        picker.hidden = true
        cancel.hidden = true
        done.hidden = true
    }
    @IBAction func saveIngredient(sender: UIBarButtonItem)
    {
        if (ingredientName.text == "" || amount.text == "" || measurement.text == "" )
        {
            var alert = UIAlertController(title: "Empty Fields", message: "Please complete all fields before saving", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        else
        {
        if (conversion.text == "none")
        {
            if (measurement.text == "none")
            {
                singleIngredient.append(amount.text)
                singleIngredient.append(ingredientName.text)
            }
            else
            {
            singleIngredient.append(amount.text)
            singleIngredient.append(measurement.text)
            singleIngredient.append(ingredientName.text)
            }
        }
        else
        {
            singleIngredient.append(amount.text)
            singleIngredient.append(conversion.text)
            singleIngredient.append(ingredientName.text)
        
        }
        var combined = " ".join(singleIngredient)
        ingredientsArray.append(combined)
        self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return units[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        value = row
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
