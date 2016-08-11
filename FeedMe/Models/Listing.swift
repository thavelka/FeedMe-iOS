//
//  Listing.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/8/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import Foundation
import Firebase

class Listing: NSObject {
    
    enum Type: String {
        case Food = "food"
        case Drink = "drink"
    }
    
    var id: String
    var userId: String
    var placeId: String
    var cityId: String
    var type: Type?
    var listingDescription: String
    var days: [String: Bool]
    
    init(id: String, userId: String, placeId: String, cityId: String, type: String, description: String, days: [String: Bool]) {
        self.id = id
        self.userId = userId
        self.placeId = placeId
        self.cityId = cityId
        self.type = Type(rawValue: type)
        self.listingDescription = description
        self.days = days
    }
    
    init(id: String, values: [String: AnyObject]) {
        self.id = id
        self.userId = values["userId"] as? String ?? ""
        self.placeId = values["placeId"] as? String ?? ""
        self.cityId = values["cityId"] as? String ?? ""
        self.type = Type(rawValue: values["type"] as? String ?? "")
        self.listingDescription = values["description"] as? String ?? ""
        self.days = values["days"] as? [String: Bool] ?? [:]
    }
    
    convenience override init() {
        self.init(id: "", userId: "", placeId: "", cityId: "", type: "", description: "", days: [:])
    }
    
    func getValues() -> [String: [String: AnyObject]] {
        var values = [String: AnyObject]()
        values["userId"] = self.userId
        values["placeId"] = self.placeId
        values["cityId"] = self.cityId
        values["type"] = self.type?.rawValue
        values["description"] = self.listingDescription
        values["days"] = self.days
        
        return ["listings/\(self.id)": values]
    }
    
    func save() {
        let ref = FIRDatabase.database().reference()
        if self.id.isEmpty {
            self.id = ref.child("listings").childByAutoId().key
        }
        ref.updateChildValues(self.getValues())
    }
}