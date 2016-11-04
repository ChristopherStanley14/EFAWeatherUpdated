//
//  InteractionController.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/21/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit

// Step 9: Create and implement class
class InteractionController: UIPercentDrivenInteractiveTransition {
    
    var interactionInProgress = false
    
    fileprivate var shouldCompleteTransition = false
    fileprivate weak var viewController: UIViewController!
    
    func wireToViewController(_ viewController: UIViewController!) {
        self.viewController = viewController
        prepareGestureRecognizerInView(viewController.view)
    }
    
    fileprivate func prepareGestureRecognizerInView(_ view: UIView) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        gesture.edges = UIRectEdge.left
        view.addGestureRecognizer(gesture)
    }
    
    func handleGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var progress = (translation.x / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
            
        case .began:
            interactionInProgress = true
            viewController.dismiss(animated: true, completion: nil)
            
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
            
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        case .ended:
            interactionInProgress = false
            
            if !shouldCompleteTransition {
                cancel()
            } else {
                finish()
            }
            
        default:
            break
        }
    }
}
