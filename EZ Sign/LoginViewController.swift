//
//  LoginViewController.swift
//  EZ Sign
//  An app to sign in and out for dorm students.
//
//  Created by Jimmy on 4/28/16.
//  Copyright © 2016 SSFS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Import BaasBox.
    let client = BAAClient.sharedClient()
    
    // Clear errors.
    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    // Connect the elements from the view.
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    // Let the user logi in when the button is tapped.
    @IBAction func loginTapped(sender: UIButton) {
        loginButton.enabled = false
        spinner.startAnimating()
        
        // Authenticate the user on BaasBox.
        client.authenticateUser(usernameField.text, password: passwordField.text, completion: { (success: Bool, error: NSError!) -> () in
            self.spinner.stopAnimating()
            self.loginButton.enabled = true
            
            if success {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                self.errorLabel.text = error.localizedDescription
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the spinner and error label when inactive. 
        spinner.hidesWhenStopped = true
        errorLabel.text = ""
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
