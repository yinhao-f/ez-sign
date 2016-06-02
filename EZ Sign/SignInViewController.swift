//
//  SignInViewController.swift
//  EZ Sign
//  An app to sign in and out for dorm students.
//
//  Created by Jimmy on 5/4/16.
//  Copyright © 2016 SSFS. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var namePicker: UIPickerView!
    
    @IBAction func continueButton(sender: UIButton) {
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var records: [Record] = []
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        Record.getObjectsWithCompletion({(object: [AnyObject]!, error: NSError!) -> () in
            if error == nil {
                self.records = object as! [Record]
                
                self.namePicker.reloadAllComponents()
            } else {
                print("Error retrieving records.")
            }
        })
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return records.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return records[row].name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect the name picker to self.
        namePicker.dataSource = self
        namePicker.delegate = self
        
        // Do any additional setup after loading the view.
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
