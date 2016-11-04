//
//  WatchSessionManager.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/23/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit
import WatchConnectivity

// Step 16: Create/implement WatchSessionManager
class WatchSessionManager: NSObject, WCSessionDelegate {
    @available(iOS 9.3, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    /** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
    @available(iOS 9.3, *)
    public func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    /** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
    @available(iOS 9.3, *)
    public func sessionDidDeactivate(_ session: WCSession) {
        
    }

    static let shared = WatchSessionManager()
    fileprivate override init() {
        super.init()
    }
    
    fileprivate let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    fileprivate var validSession: WCSession? {
        if let session = session , session.isPaired && session.isWatchAppInstalled {
            return session
        }
        return nil
    }
    
    func startSession() {
        session?.delegate = self
        session?.activate()
    }
}

extension WatchSessionManager {
    func updateApplicationContext(_ applicationContext: [String : AnyObject]) throws {
        if let session = validSession {
            do {
                try session.updateApplicationContext(applicationContext)
            } catch let error {
                print(error)
                throw error
            }
        }
    }
}
