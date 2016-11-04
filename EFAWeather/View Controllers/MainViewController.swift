//
//  MainViewController.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/21/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SegueHandlerType {
    // Step 5: Add forecastButton
    var forecastButton: UIBarButtonItem!
    
    // Step 7: Add animation controllers
    fileprivate let flipAnimationController = FlipAnimationController()
    fileprivate let flipBackAnimationController = FlipBackAnimationController()
    
    // Step 8: add interactive controller
    fileprivate let interactionController = InteractionController()
    
    enum SegueIdentifier: String {
        case ShowForecast
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 5: init forecastButton and call showHideNavButton()
        forecastButton = UIBarButtonItem(title: "Forecast", style: .plain, target: self, action: #selector(goToForecast))
        showHideNavButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Step 5: add viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        showHideNavButton()
    }
    
    // Step 5: create goToForecast and showHideNaveButton functions
    func goToForecast() {
        self.performSegueWithIdentifier(.ShowForecast, sender: self)
    }
    
    func showHideNavButton() {
        if self.traitCollection.horizontalSizeClass == .regular {
            navigationItem.rightBarButtonItem = nil
        } else {
            navigationItem.rightBarButtonItem = forecastButton
        }
    }
    
    // Step 7: implement prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.transitioningDelegate = self
        
        // Step 8: add wire up interactionController
        interactionController.wireToViewController(segue.destination)
    }
    
    // Step 17: create and implement
    @IBAction func sendNotification(_ sender: AnyObject) {
        let alertTime = Date().addingTimeInterval(5)
        
        let notifyAlarm = UILocalNotification()
        
        notifyAlarm.fireDate = alertTime
        notifyAlarm.timeZone = TimeZone.current
        notifyAlarm.soundName = UILocalNotificationDefaultSoundName
        notifyAlarm.category = "WEATHER_HAPPENING"
        notifyAlarm.alertTitle = "Weather Happening"
        notifyAlarm.alertBody = "It looks like some weather is going to be happening, you should definitely get prepared for it\n"
        UIApplication.shared.scheduleLocalNotification(notifyAlarm)
    }
}


// Step 7: add UIViewControllerTransitioningDelegate extension
extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        flipAnimationController.originFrame = self.view.frame
        return flipAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var frame = self.view.frame
        if self.traitCollection.horizontalSizeClass == .regular {
            frame = CGRect(x: 0, y: 0, width: frame.size.height, height: frame.size.width)
        }
        flipBackAnimationController.destinationFrame = frame
        return flipBackAnimationController
    }
    
    // Step 8: implement interactionControllerForDismissal function
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController.interactionInProgress ? interactionController : nil
    }
}
