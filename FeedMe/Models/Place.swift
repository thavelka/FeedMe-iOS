//
//  Place.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/8/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import Foundation
import Firebase

class Place: NSObject {
    
    var id: String
    var name: String
    var address: String
    var cityId: String
    var imageUrl: String
    
    init(id: String, name: String, address: String, cityId: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.address = address
        self.cityId = cityId
        self.imageUrl = imageUrl
    }
    
    init(id: String, values: [String: AnyObject]) {
        self.id = id
        self.name = values["name"] as? String ?? ""
        self.address = values["address"] as? String ?? ""
        self.cityId = values["cityId"] as? String ?? ""
        self.imageUrl = values["imageUrl"] as? String ?? ""
    }
    
    convenience override init() {
        self.init(id: "", name: "", address: "", cityId: "", imageUrl: "")
    }
    
    func getValues() -> [String: [String: AnyObject]] {
        var values = [String: AnyObject]()
        values["name"] = self.name
        values["address"] = self.address
        values["cityId"] = self.cityId
        values["imageUrl"] = self.imageUrl
        
        return ["places/\(self.id)": values]
    }
    
    func save() {
        let ref = FIRDatabase.database().reference()
        if self.id.isEmpty {
            self.id = ref.child("places").childByAutoId().key
        }
        ref.updateChildValues(self.getValues())
    }
}