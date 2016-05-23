//
//  SignOutViewController.swift
//  EZ Sign
//  An app to sign in and out for dorm students.
//
//  Created by Jimmy on 5/4/16.
//  Copyright © 2016 SSFS. All rights reserved.
//

import UIKit

class SignOutViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var driverField: UITextField!
    @IBOutlet weak var returnTimePicker: UIDatePicker!
    @IBOutlet weak var destinationPicker: UIPickerView!
    
    var destination: String = ""
    var newRecord = Record()
    
    // Set the number of columns in destination picker.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Retrieve data from BaasBox for destination choices.
    var destinationChoices = Destination()
    var locations: [String] = []
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        Destination.getObjectWithId("e54270be-4ba0-4718-bc96-5e07b2e13ccc", completion: { (location: AnyObject!, error: NSError!) -> () in
            if error == nil {
                self.destinationChoices = location as! Destination
                self.locations = self.destinationChoices.destinations
                
                // Refresh the picker.
                self.destinationPicker.reloadAllComponents()
            } else {
                print("Error loading destinations.")
            }
        })
    }
        
    // Set the number of rows in destination picker.
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    
    // Content for each row in the destination picker.
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locations[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Check if the user chooses the "other" option. Display the text field if chosen.
        if locations[row] == "Other" {
            destinationField.hidden = false
            destination = destinationField.text!
        } else {
            destinationField.hidden = true
            destination = locations[row]
        }
    }
    
    @IBAction func continueButton(sender: UIButton) {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .LongStyle
        
        newRecord.name = nameField.text!
        newRecord.phoneNumber = phoneNumberField.text!
        newRecord.destinationChoice = destination
        newRecord.driver = driverField.text!
        newRecord.returnTime = formatter.stringFromDate(returnTimePicker.date)
        
        newRecord.saveObjectWithCompletion({(object: AnyObject!, error: NSError!) -> () in
            if error == nil {
                print("Success!")
            } else {
                print("Error!")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        destinationPicker.dataSource = self
        destinationPicker.delegate = self
        // Hide the custom destination box when "other" is not chosen.
        destinationField.hidden = true
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
