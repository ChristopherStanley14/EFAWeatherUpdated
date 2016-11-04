//
//  WatchSessionManager.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/23/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Freddy

// Step 16: Create and implement class
protocol WatchSessionDelegate {
    func newData()
}

class WatchSessionManager: NSObject, WCSessionDelegate {
    /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    static let shared = WatchSessionManager()
    fileprivate override init() {
        super.init()
    }
    
    fileprivate var watchSessionDelegates = [WatchSessionDelegate]()
    
    fileprivate let session: WCSession = WCSession.default()
    
    func startSession() {
        session.delegate = self
        session.activate()
    }
    
    func addWatchSessionDelegate<T>(_ delegate: T) where T: WatchSessionDelegate, T: Equatable {
        watchSessionDelegates.append(delegate)
    }
    
    func removeWatchSessionDelegate<T>(_ delegate: T) where T: WatchSessionDelegate, T: Equatable {
        for (index, indexDelegate) in watchSessionDelegates.enumerated() {
            if let indexDelegate = indexDelegate as? T , indexDelegate == delegate {
                watchSessionDelegates.remove(at: index)
                break
            }
        }
    }
}

extension WatchSessionManager {
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let weatherInfo = applicationContext[Constants.weatherUpdated] as? JSON {
            do {
                UserStore.shared.weatherInfo = try Forecast(json: weatherInfo)
                DispatchQueue.main.async { [weak self] in
                    self?.watchSessionDelegates.forEach { $0.newData() }
                }
            } catch {
                
            }
        }
    }
}
