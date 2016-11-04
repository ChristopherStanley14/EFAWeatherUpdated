//
//  WatchUtils.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/23/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import Foundation

// Step 14: create class
class WatchUtils {
    
    // Step 14: implement formatDouble
    class func formatDouble(_ number: Double?) -> String {
        guard let number = number else {
            return ""
        }
        
        return "\(Int(number))"
    }
    
    // Step 15: implement dayOfWeek
    class func dayOfWeek(from timeStamp: Int?) -> String {
        guard let timeStamp = timeStamp else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: Double(timeStamp))
        let cal = Calendar.current
        let components = (cal as NSCalendar).components(.weekday, from: date)
        switch components.weekday {
        case 1?:
            return "Sun"
        case 2?:
            return "Mon"
        case 3?:
            return "Tue"
        case 4?:
            return "Wed"
        case 5?:
            return "Thu"
        case 6?:
            return "Fri"
        case 7?:
            return "Sat"
        default:
            return ""
        }
    }
}
