//
//  Forecast.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/8/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

class Forecast: NetworkModel {
    var latitude: Double?
    var longitude: Double?
    var timezone: String?
    var offset: Int?
    var currentWeather: WeatherData?
    var minuteWeather: FutureWeather?
    var hourlyWeather: FutureWeather?
    var dailyWeather: FutureWeather?
    
    required init() {}
    
    required init(json: JSON) throws {
        // Step 16: update watch context
        #if os(iOS)
            do {
                try WatchSessionManager.shared.updateApplicationContext([Constants.weatherUpdated: json as AnyObject])
            } catch {
                print("error updating watch context")
            }
        #endif
        
        latitude = try? json.getDouble(at: Constants.Forecast.latitude)
        longitude = try? json.getDouble(at: Constants.Forecast.longitude)
        timezone = try? json.getString(at: Constants.Forecast.timezone)
        offset = try? json.getInt(at: Constants.Forecast.offset)
        
        currentWeather = try? WeatherData(json: JSON(json.getDictionary(at: Constants.Forecast.currently)))
        minuteWeather = try? FutureWeather(json: JSON(json.getDictionary(at: Constants.Forecast.minutely)))
        hourlyWeather = try? FutureWeather(json: JSON(json.getDictionary(at: Constants.Forecast.hourly)))
        dailyWeather = try? FutureWeather(json: JSON(json.getDictionary(at: Constants.Forecast.daily)))
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func method() -> Alamofire.HTTPMethod {
        return .get
    }
    
    func path() -> String {
        return "/\(UserStore.shared.apiToken)/\(latitude!),\(longitude!)"
    }
    
    func toDictionary() -> [String: AnyObject]? {
        return nil
    }
}
