//
//  Place.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/8/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import Foundation

class Place: NSObject {
    var uid: String
    var name: String
    var address: String
    
    init(uid: String, name: String, address: String) {
        self.uid = uid
        self.name = name
        self.address = address
    }
    
    convenience override init() {
        self.init(uid: "", name: "", address: "")
    }
}