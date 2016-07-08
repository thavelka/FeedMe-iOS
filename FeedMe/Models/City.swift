//
//  City.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/8/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import Foundation

class City: NSObject {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience override init() {
        self.init(name: "")
    }
}