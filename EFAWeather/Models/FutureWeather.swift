//
//  FutureWeather.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/8/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

class FutureWeather {
    var summary: String?
    var icon: String?
    var data: [WeatherData]?
    
    init(json: JSON) throws {
        summary = try? json.getString(at: Constants.FutureWeather.summary)
        icon = try? json.getString(at: Constants.FutureWeather.icon)
        data = try? json.getArray(at: Constants.FutureWeather.data).map(WeatherData.init)
    }
}
