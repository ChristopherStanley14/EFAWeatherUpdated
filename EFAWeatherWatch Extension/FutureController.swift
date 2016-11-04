//
//  FutureController.swift
//  EFAWeather
//
//  Created by Christopher Stanley on 11/4/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import WatchKit
import Foundation


class FutureController: WKInterfaceController {
    
    @IBOutlet var tableView: WKInterfaceTable!
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}