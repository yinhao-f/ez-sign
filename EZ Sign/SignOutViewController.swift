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
    
    // Set the number of columns in destination picker.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var destinationChoices: [Destination] = []
    var locations = [String]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        Destination.getObjectsWithCompletion( { (destination: [AnyObject]!, error: NSError!) -> () in
            if error == nil {
                self.destinationChoices = destination as! [Destination]
                self.locations = self.destinationChoices[0].destinations
            } else {
                print("Error loading destinations")
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
        // Check if the user chose the "other" option. Display the text field if chosen.
        if locations[row] == "Other" {
            destinationField.hidden = false
        } else {
            destinationField.hidden = true
        }
    }
    
    @IBAction func continueButton(sender: UIButton) {
        // TODO: Upload information to BaasBox and display an alert when the user taps it.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
