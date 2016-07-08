//
//  User.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/8/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import Foundation

class User: NSObject {
    var name: String
    var city: String
    
    init(name: String, city: String) {
        self.name = name
        self.city = city
    }
    
    convenience override init() {
        self.init(name: "", city: "")
    }
}