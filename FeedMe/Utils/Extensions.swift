//
//  Extensions.swift
//  FeedMe
//
//  Created by Tim Havelka on 8/11/16.
//  Copyright © 2016 Tim Havelka. All rights reserved.
//

import Foundation

extension NSDate {
    /// Returns day of week as an integer. Sunday = 1, Saturday = 7.
    func dayOfWeek() -> Int? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components(.Weekday, fromDate: self) else { return nil }
        return comp.weekday
    }
    
    /// Returns day of week as a localized string (e.g. "Sunday").
    func dayOfWeekName() -> String? {
        guard let day = dayOfWeek() where day >= 1 && day <= 7 else { return nil }
        return NSDateFormatter().weekdaySymbols[day - 1]
    }
}
