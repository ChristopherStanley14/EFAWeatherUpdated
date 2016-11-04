//
//  FutureController.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/22/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import WatchKit
import Foundation

// Step 13: create class
class FutureController: WKInterfaceController {
    @IBOutlet var tableView: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        // Step 15: add notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(setupView), name: NSNotification.Name(rawValue: Constants.weatherUpdated), object: nil)
        setupView()
        
        // Step 16: set as WatchSessionDelegate
        WatchSessionManager.shared.addWatchSessionDelegate(self)
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        
        // Step 15: remove notification observer
        NotificationCenter.default.removeObserver(self)
        
        // Step 16: remove from WatchSessionDelegates
        WatchSessionManager.shared.removeWatchSessionDelegate(self)
    }
    
    func setupView() {
        if let dailyWeather = UserStore.shared.weatherInfo?.dailyWeather?.data {
            tableView.setNumberOfRows(dailyWeather.count, withRowType: "WeatherRow")
            
            for (index, data) in dailyWeather.enumerated() {
                if let controller = tableView.rowController(at: index) as? WeatherRowController {
                    controller.weatherData = data
                }
            }
        } else {
            tableView.setNumberOfRows(0, withRowType: "WeatherRow")
        }
    }
}

// Step 16: implement WatchSessionDelegate extension
extension FutureController: WatchSessionDelegate {
    func newData() {
        setupView()
    }
}
