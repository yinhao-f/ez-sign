//
//  Record.swift
//  EZ Sign
//  An app to sign in and out for dorm students.
//
//  Created by Yinhao Feng on 5/23/16.
//  Copyright © 2016 SSFS. All rights reserved.
//

import UIKit

class Record: BAAObject {
    var name = ""
    var phoneNumber = ""
    var destinationChoice = ""
    var driver = ""
    var signOutTime = ""
    var returnTime = ""
    
    override init(dictionary: [NSObject: AnyObject]!) {
        self.name = dictionary["name"]! as! String
        self.phoneNumber = dictionary["phoneNumber"]! as! String
        self.destinationChoice = dictionary["destinationChoice"]! as! String
        self.driver = dictionary["driver"]! as! String
        self.signOutTime = dictionary["signOutTime"]! as! String
        self.returnTime = dictionary["returnTime"]! as! String
        super.init(dictionary: dictionary)
    }
    
    override func collectionName() -> String! {
        return "document/yf_ez-sign-records"
    }
}