//
//  Destination.swift
//  EZ Sign
//  An app to sign in and out for dorm students.
//
//  Created by Jimmy on 5/12/16.
//  Copyright © 2016 SSFS. All rights reserved.
//

import UIKit

class Destination: BAAObject {
    // This is a class for retrieving destination data from Baasbox.
    
    var destinations: [String]
    
    override init(dictionary: [NSObject : AnyObject]!) {
        self.destinations = dictionary["destinations"]! as! [String]
        super.init(dictionary: dictionary)
    }
    
    override func collectionName() -> String! {
        return "document/yf_ez-sign-destination"
    }
}