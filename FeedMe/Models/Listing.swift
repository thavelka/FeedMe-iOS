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
    var placeName: String
    var placeAddress: String
    var listingDescription: String
    
    init(uid: String, place: String, address: String, description: String) {
        self.uid = uid
        self.placeName = place
        self.placeAddress = address
        self.listingDescription = description
    }
    
    convenience override init() {
        self.init(uid: "", place: "", address: "", description: "")
    }
}