//
//  City.swift
//  FeedMe
//
//  Created by Tim Havelka on 7/8/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import Foundation
import Firebase

class City: NSObject {
    var id: String
    var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(id: String, values: [String: AnyObject]) {
        self.id = id
        self.name = values["name"] as? String ?? ""
    }
    
    convenience override init() {
        self.init(id: "", name: "")
    }
    
    func getValues() -> [String: [String: AnyObject]] {
        var values = [String: AnyObject]()
        values["name"] = self.name
        return ["cities/\(self.id)" : values]
    }
    
    func save() {
        let ref = FIRDatabase.database().reference()
        if self.id.isEmpty {
            self.id = ref.child("cities").childByAutoId().key
        }
        ref.updateChildValues(self.getValues())
    }
}