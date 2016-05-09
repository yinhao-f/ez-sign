//
//  HomeViewController.swift
//  EZ Sign
//  An app to sign in and out for dorm students.
//
//  Created by Jimmy on 4/28/16.
//  Copyright © 2016 SSFS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Check if the user is logged in.
        let client = BAAClient.sharedClient()
        if client.isAuthenticated() {
            statusLabel.text = "Welcome!"
        } else {
            statusLabel.text = "Not Logged in."
            self.navigationController?.performSegueWithIdentifier("showLogin", sender: nil)
        }
    }
    
    // Direct the user to the sign out view once the button is tapped.
    @IBAction func signOutTapped(sender: UIButton) {
        navigationController?.performSegueWithIdentifier("showSignOut", sender: nil)
    }
    
    //Direct the user to the sign in view once the button is tapped.
    @IBAction func signInTapped(sender: UIButton) {
        navigationController?.performSegueWithIdentifier("showSignIn", sender: nil)
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
