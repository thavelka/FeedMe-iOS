//
//  Listing.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/8/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import Foundation

class Listing: NSObject {
    var uid: String
    var place: String
    var city: String
    var user: String
    var listingDescription: String
    var days: [String: Bool]
    
    init(uid: String, place: String, city: String, user: String, description: String, days: [String: Bool]) {
        self.uid = uid
        self.place = place
        self.city = city
        self.user = user
        self.listingDescription = description
        self.days = days
    }
    
    convenience override init() {
        self.init(uid: "", place: "", city: "", user: "", description: "", days: [:])
    }
}