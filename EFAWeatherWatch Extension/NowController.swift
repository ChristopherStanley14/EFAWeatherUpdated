//
//  NowController.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/22/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import WatchKit
import Foundation

// Step 13: create class
class NowController: WKInterfaceController {
    @IBOutlet var tempLabel: WKInterfaceLabel!
    @IBOutlet var conditionLabel: WKInterfaceLabel!
    @IBOutlet var lowLabel: WKInterfaceLabel!
    @IBOutlet var highLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        // Step 14: add notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(setupView), name: NSNotification.Name(rawValue: Constants.weatherUpdated), object: nil)
        setupView()
        UserStore.shared.locationManager.requestLocation()
        
        // Step 16: set as WatchSessionDelegate
        WatchSessionManager.shared.addWatchSessionDelegate(self)
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        // Step 14: remove notification observer
        NotificationCenter.default.removeObserver(self)
        
        // Step 16: remove from WatchSessionDelegates
        WatchSessionManager.shared.removeWatchSessionDelegate(self)
    }
    
    // Step 14: implement setupView
    func setupView() {
        if let current = UserStore.shared.weatherInfo?.currentWeather {
            tempLabel.setText("\(WatchUtils.formatDouble(current.temperature))º")
            conditionLabel.setText(current.summary ?? "")
        } else {
            tempLabel.setText("")
            conditionLabel.setText("")
        }
        if let dailyWeather = UserStore.shared.weatherInfo?.dailyWeather, let todayWeather = dailyWeather.data?[0] {
            lowLabel.setText("\(WatchUtils.formatDouble(todayWeather.temperatureMin))º")
            highLabel.setText("\(WatchUtils.formatDouble(todayWeather.temperatureMax))º")
        } else {
            highLabel.setText("")
            lowLabel.setText("")
        }
    }
}

// Step 16: implement WatchSessionDelegate extension
extension NowController: WatchSessionDelegate {
    func newData() {
        setupView()
    }
}
