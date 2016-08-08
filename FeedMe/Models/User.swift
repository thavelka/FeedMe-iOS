//
//  User.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/8/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import Foundation

class User: NSObject {
    var id: String
    var name: String
    var email: String
    var cityId: String
    var favorites: [String: Bool]?
    
    init(id: String, name: String, email: String, cityId: String) {
        self.id = id
        self.name = name
        self.email = email
        self.cityId = cityId
    }
    
    init(id: String, values: [String: AnyObject]) {
        self.id = id
        self.name = values["name"] as? String ?? ""
        self.email = values["email"] as? String ?? ""
        self.cityId = values["cityId"] as? String ?? ""
    }
    
    convenience override init() {
        self.init(id: "", name: "", email: "", cityId: "")
    }
}