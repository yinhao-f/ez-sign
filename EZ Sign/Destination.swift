//
//  Destination.swift
//  EZ Sign
//
//  Created by Jimmy on 5/12/16.
//  Copyright © 2016 SSFS. All rights reserved.
//

import UIKit

class Destination: BAAObject {
    var destinations: [String]
    
    override init(dictionary: [NSObject: AnyObject]!) {
        self.destinations = dictionary["destinations"]! as! [String]
        super.init(dictionary: dictionary)
    }
    
    override func collectionName() -> String! {
        return "document/yf_ez-sign-destination"
    }
}