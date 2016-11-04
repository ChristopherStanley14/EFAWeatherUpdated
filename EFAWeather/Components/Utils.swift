//
//  Utils.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/21/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import Foundation

class Utils {
    class func intFromDouble(_ number: Double?) -> String {
        guard let number = number else {
            return ""
        }
        return "\(Int(number))"
    }
    
    class func formatDouble(_ number: Double?) -> String {
        guard let number = number else {
            return ""
        }
        return String(format: "%.2f", number)
    }
    
    class func formatInt(_ number: Int?) -> String {
        guard let number = number else {
            return ""
        }
        return "\(number)"
    }
    
    class func timeFromTimestamp(_ timestamp: Int?) -> String {
        guard let timestamp = timestamp  else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = Date(timeIntervalSince1970: Double(timestamp))
        return dateFormatter.string(from: date)
    }
}
