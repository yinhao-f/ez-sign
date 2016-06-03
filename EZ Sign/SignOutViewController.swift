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
    
    // Connecting outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var driverField: UITextField!
    @IBOutlet weak var returnTimePicker: UIDatePicker!
    @IBOutlet weak var destinationPicker: UIPickerView!

    // Set the number of columns in destination picker.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Retrieve data from BaasBox for destination choices.
    var destinationChoices = Destination()
    var locations: [String] = []
    
    // Collect current time from the return date picker before the user chooses it.
    var currentTime = NSDate()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.currentTime = returnTimePicker.date
        
        // Retrieve destination data.
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
    
    // Check if the user chooses the "other" option. Display the text field if chosen.
    var otherChosen = false
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if locations[row] == "Other" {
            destinationField.hidden = false
            otherChosen = true
        } else {
            destinationField.hidden = true
            otherChosen = false
        }
    }
    
    // Assign the subclass for a new record.
    var newRecord = Record()
    
    @IBAction func continueButton(sender: UIButton) {
        // Set the format for the sign out and return dates.
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        
        // Assign the corresponding values to the subclass.
        newRecord.name = nameField.text!
        newRecord.phoneNumber = phoneNumberField.text!
        
        // Decide the actual destination.
        if otherChosen {
            newRecord.destinationChoice = destinationField.text!
        } else {
            newRecord.destinationChoice = locations[destinationPicker.selectedRowInComponent(0)]
        }
        
        newRecord.driver = driverField.text!
        newRecord.signOutTime = formatter.stringFromDate(currentTime)
        newRecord.returnTime = formatter.stringFromDate(returnTimePicker.date)
        newRecord.signedIn = false
        
        // Check if all fields are completed.
        var completedFields = true        
        if nameField.text == "" {
            completedFields = false
        }
        if phoneNumberField.text == "" {
            completedFields = false
        }
        
        if driverField.text == "" {
            completedFields = false
        }
        
        if newRecord.destinationChoice == "" {
            completedFields = false
        }
        
        // Save the record to BaasBox.
        if completedFields {
            newRecord.saveObjectWithCompletion({(object: AnyObject!, error: NSError!) -> () in
                // Implement an alert that returns the user to home view after the record is uploaded successfully.
                let successAlert = UIAlertController(title: "EZ Sign", message: "Success! Your information has been recorded.", preferredStyle: UIAlertControllerStyle.Alert)
                successAlert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                    self.navigationController?.popViewControllerAnimated(true)
                }))
                self.presentViewController(successAlert, animated: true, completion: nil)
            })
        } else {
            // Display an alert when some fields are not filled.
            let errorAlert = UIAlertController(title: "EZ Sign", message: "Please check and complete all fields.", preferredStyle: UIAlertControllerStyle.Alert)
            errorAlert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(errorAlert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect the destination picker to self.
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
