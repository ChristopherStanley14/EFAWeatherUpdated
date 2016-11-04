//
//  WeatherRowController.swift
//  EFAWeather
//
//  Created by Christopher Stanley on 11/4/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import WatchKit

class WeatherRowController: NSObject {
    
    @IBOutlet var dayLabel: WKInterfaceLabel!
    @IBOutlet var highLabel: WKInterfaceLabel!
    @IBOutlet var lowLabel: WKInterfaceLabel!
    @IBOutlet var conditionLabel: WKInterfaceLabel!
    
    var weatherData: WeatherData? {
        didSet {
            if let weatherData = weatherData {
                dayLabel.setText(WatchUtils.dayOfWeek(from: weatherData.time))
                highLabel.setText(WatchUtils.formatDouble(weatherData.temperatureMax))
                lowLabel.setText(WatchUtils.formatDouble(weatherData.temperatureMin))
                conditionLabel.setText(weatherData.summary ?? "")
            }
        }
    }
}
