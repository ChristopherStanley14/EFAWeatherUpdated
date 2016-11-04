//
//  UserStore.swift
//  EFAB
//
//  Created by Brett Keck on 5/18/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

#if os(watchOS)
import ClockKit
#endif

// Step 2: change to NSObject
class UserStore: NSObject {
    static let shared = UserStore()
    
    // Step 2: Add locationManager and lastLocation
    let locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    var lastUpdate: Date?

    // Step 3: add apiToken value and crate weatherInfo var
    let apiToken = "31d5888f911f2afbeafa65f275545ee3"
    var weatherInfo: Forecast? = nil {
        didSet {
            // Step 18: Reload complication on watch
            #if os(watchOS)
                let complicationServer = CLKComplicationServer.sharedInstance()
                if let activeComplications = complicationServer.activeComplications {
                    for complication in activeComplications {
                        complicationServer.reloadTimeline(for: complication)
                    }
                }
            #endif
        }
    }
    
    // Step 2: override init
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        // Step 9: Add #if os(iOS)
        #if os(iOS)
        locationManager.startUpdatingLocation()
        #endif
    }
    
    // Step 3: create getForecast function
    func getForecast() {
        if let latitude = lastLocation?.coordinate.latitude, let longitude = lastLocation?.coordinate.longitude {
            let forecast = Forecast(latitude: latitude, longitude: longitude)
            WebServices.shared.getObject(forecast, completion: { (object, error) in
                if let object = object {
                    self.weatherInfo = object
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.weatherUpdated), object: nil)
                } else {
                    // Step 9: Add #if os(iOS)
                    #if os(iOS)
                    let alert = UIAlertController(title: "Error", message: "Unable to retrieve weather info.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                    #endif
                }
            })
        }
    }
}

// Add CLLocationManagerDelegate extension
extension UserStore: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("location updated")
        
        // Step 3: call getForecast
        let newLocation = locations.first
        if lastLocation == nil || lastUpdate == nil ||
            (newLocation?.distance(from: lastLocation!))! > CLLocationDistance(200) ||
            Date().timeIntervalSince(lastUpdate!) > 600 {
            lastUpdate = Date()
            lastLocation = newLocation
            getForecast()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
