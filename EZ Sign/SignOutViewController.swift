//
//  SignOutViewController.swift
//  EZ Sign
//  An app to sign in and out for dorm students.
//
//  Created by Jimmy on 5/4/16.
//  Copyright © 2016 SSFS. All rights reserved.
//

import UIKit

class SignOutViewController: UIViewController, UIPickerViewDataSource {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var driverField: UITextField!
    
    @IBAction func continueButton(sender: UIButton) {
        // TODO: Collect information to BaasBox and display an alert when the user taps it.
    }
    
    // Set the number of columns in destination picker.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var numberOfRows:Int = 3
    
    // Set the number of rows in destination picker.
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRows
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
