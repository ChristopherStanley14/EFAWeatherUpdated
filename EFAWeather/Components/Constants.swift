//
//  Constants.swift
//  EFAB
//
//  Created by Brett Keck on 5/17/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit

struct Constants {
    
    static let weatherUpdated = "WeatherUpdatedNotification"
    
    struct JSON {
        static let unknownError = "An Unknown Error Has Occurred"
        static let processingError = "There was an error processing the response"
    }
    
    struct Forecast {
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let timezone = "timezone"
        static let offset = "offset"
        static let currently = "currently"
        static let minutely = "minutely"
        static let hourly = "hourly"
        static let daily = "daily"
    }
    
    struct FutureWeather {
        static let summary = "summary"
        static let icon = "icon"
        static let data = "data"
    }
    
    struct WeatherData {
        static let time = "time"
        static let precipitationIntensity = "precipIntensity"
        static let precipitationProbability = "precipProbability"
        static let summary = "summary"
        static let icon = "icon"
        static let temperature = "temperature"
        static let apparentTemperature = "apparentTemperature"
        static let dewPoint = "dewPoint"
        static let humidity = "humidity"
        static let windSpeed = "windSpeed"
        static let windBearing = "windBearing"
        static let visibility = "visibility"
        static let cloudCover = "cloudCover"
        static let pressure = "pressure"
        static let ozone = "ozone"
        static let sunriseTime = "sunriseTime"
        static let sunsetTime = "sunsetTime"
        static let moonPhase = "moonPhase"
        static let precipitationIntensityMax = "precipIntensityMax"
        static let temperatureMin = "temperatureMin"
        static let temperatureMinTime = "temperatureMinTime"
        static let temperatureMax = "temperatureMax"
        static let temperatureMaxTime = "temperatureMaxTime"
        static let apparentTemperatureMin = "apparentTemperatureMin"
        static let apparentTemperatureMinTime = "apparentTemperatureMinTime"
        static let apparentTemperatureMax = "apparentTemperatureMax"
        static let apparentTemperatureMaxTime = "apparentTemperatureMaxTime"
        static let nearestStormDistance = "nearestStormDistance"
        static let nearestStormBearing = "nearestStormBearing"
    }
}

// MARK: - Colors
extension UIColor {
    public class func rgba(red: NSInteger, green: NSInteger, blue: NSInteger, alpha: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
}

struct ColorPalette {
    
}
