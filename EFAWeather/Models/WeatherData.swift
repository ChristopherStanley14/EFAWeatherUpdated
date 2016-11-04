//
//  WeatherData.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/8/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit
import Alamofire
import Freddy

class WeatherData: NSObject {
    var time: Int?
    var precipitationIntensity: Double?
    var precipitationProbability: Double?
    var summary: String?
    var icon: String?
    var nearestStormDistance: Int?
    var nearestStormBearing: Int?
    var temperature: Double?
    var apparentTemperature: Double?
    var dewPoint: Double?
    var humidity: Double?
    var windSpeed: Double?
    var windBearing: Int?
    var visibility: Double?
    var cloudCover: Double?
    var pressure: Double?
    var ozone: Double?
    var sunriseTime: Int?
    var sunsetTime: Int?
    var moonPhase: Double?
    var precipitationIntensityMax: Double?
    var temperatureMin: Double?
    var temperatureMinTime: Int?
    var temperatureMax: Double?
    var temperatureMaxTime: Int?
    var apparentTemperatureMin: Double?
    var apparentTemperatureMinTime: Int?
    var apparentTemperatureMax: Double?
    var apparentTemperatureMaxTime: Int?
    
    init(json: JSON) throws {
        time = try? json.getInt(at: Constants.WeatherData.time)
        precipitationIntensity = try? json.getDouble(at: Constants.WeatherData.precipitationIntensity)
        precipitationProbability = try? json.getDouble(at: Constants.WeatherData.precipitationProbability)
        summary = try? json.getString(at: Constants.WeatherData.summary)
        icon = try? json.getString(at: Constants.WeatherData.icon)
        nearestStormDistance = try? json.getInt(at: Constants.WeatherData.nearestStormDistance)
        nearestStormBearing = try? json.getInt(at: Constants.WeatherData.nearestStormBearing)
        temperature = try? json.getDouble(at: Constants.WeatherData.temperature)
        apparentTemperature = try? json.getDouble(at: Constants.WeatherData.apparentTemperature)
        dewPoint = try? json.getDouble(at: Constants.WeatherData.dewPoint)
        humidity = try? json.getDouble(at: Constants.WeatherData.humidity)
        windSpeed = try? json.getDouble(at: Constants.WeatherData.windSpeed)
        windBearing = try? json.getInt(at: Constants.WeatherData.windBearing)
        visibility = try? json.getDouble(at: Constants.WeatherData.visibility)
        cloudCover = try? json.getDouble(at: Constants.WeatherData.cloudCover)
        pressure = try? json.getDouble(at: Constants.WeatherData.pressure)
        ozone = try? json.getDouble(at: Constants.WeatherData.ozone)
        sunriseTime = try? json.getInt(at: Constants.WeatherData.sunriseTime)
        sunsetTime = try? json.getInt(at: Constants.WeatherData.sunsetTime)
        moonPhase = try? json.getDouble(at: Constants.WeatherData.moonPhase)
        precipitationIntensityMax = try? json.getDouble(at: Constants.WeatherData.precipitationIntensityMax)
        temperatureMin = try? json.getDouble(at: Constants.WeatherData.temperatureMin)
        temperatureMinTime = try? json.getInt(at: Constants.WeatherData.temperatureMinTime)
        temperatureMax = try? json.getDouble(at: Constants.WeatherData.temperatureMax)
        temperatureMaxTime = try? json.getInt(at: Constants.WeatherData.temperatureMaxTime)
        apparentTemperatureMin = try? json.getDouble(at: Constants.WeatherData.apparentTemperatureMin)
        apparentTemperatureMinTime = try? json.getInt(at: Constants.WeatherData.apparentTemperatureMinTime)
        apparentTemperatureMax = try? json.getDouble(at: Constants.WeatherData.apparentTemperatureMax)
        apparentTemperatureMaxTime = try? json.getInt(at: Constants.WeatherData.apparentTemperatureMaxTime)
    }
    
    override var description: String {
        var desc = ""
        
        desc += "time: \(time)\n"
        desc += "precipitationIntensity: \(precipitationIntensity)\n"
        desc += "precipitationProbabilility: \(precipitationProbability)\n"
        desc += "summary: \(summary)\n"
        desc += "icon: \(icon)\n"
        desc += "nearestStormDistance: \(nearestStormDistance)\n"
        desc += "nearestStormBearing: \(nearestStormBearing)\n"
        desc += "temperature: \(temperature)\n"
        desc += "apparentTemperature: \(apparentTemperature)\n"
        desc += "dewPoint: \(dewPoint)\n"
        desc += "humidity: \(humidity)\n"
        desc += "windSpeed: \(windSpeed)\n"
        desc += "windBearing: \(windBearing)\n"
        desc += "visibility: \(visibility)\n"
        desc += "cloudCover: \(cloudCover)\n"
        desc += "pressure: \(pressure)\n"
        desc += "ozone: \(ozone)\n"
        desc += "sunriseTime: \(sunriseTime)\n"
        desc += "sunsetTime: \(sunsetTime)\n"
        desc += "moonPhase: \(moonPhase)\n"
        desc += "precipitationIntensityMax: \(precipitationIntensityMax)\n"
        desc += "temperatureMin: \(temperatureMin)\n"
        desc += "temperatureMinTime: \(temperatureMinTime)\n"
        desc += "temperatureMax: \(temperatureMax)\n"
        desc += "temperatureMaxTime: \(temperatureMaxTime)\n"
        desc += "apparentTemperatureMin: \(apparentTemperatureMin)\n"
        desc += "apparentTemperatureMinTime: \(apparentTemperatureMinTime)\n"
        desc += "apparentTemperatureMax: \(apparentTemperatureMax)\n"
        desc += "apparentTemperatureMaxTime: \(apparentTemperatureMaxTime)\n"
        
        return desc
    }
}
