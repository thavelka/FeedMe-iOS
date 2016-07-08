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
    var city: String
    
    init(uid: String, name: String, address: String, city: String) {
        self.uid = uid
        self.name = name
        self.address = address
        self.city = city
    }
    
    convenience override init() {
        self.init(uid: "", name: "", address: "", city: "")
    }
}