//
//  FlipBackAnimationController.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/21/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit

class FlipBackAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  var destinationFrame = CGRect.zero
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.6
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
        return
    }
    
    let containerView = transitionContext.containerView
    
    toVC.view.frame = transitionContext.finalFrame(for: toVC)
    let finalFrame = destinationFrame
    
    let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
    let toSnapshot = toVC.view.snapshotView(afterScreenUpdates: true)
    
    containerView.addSubview(toSnapshot!)
    containerView.addSubview(snapshot!)
    fromVC.view.isHidden = true
    
    AnimationHelper.perspectiveTransformForContainerView(containerView)
    toSnapshot?.layer.transform = AnimationHelper.yRotation(-M_PI_2)
    let duration = transitionDuration(using: transitionContext)
    
    UIView.animateKeyframes (
      withDuration: duration,
      delay: 0,
      options: .calculationModeCubic,
      animations: {
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
          snapshot?.frame = finalFrame
        })
        
        UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
          snapshot!.layer.transform = AnimationHelper.yRotation(M_PI_2)
        })
        
        UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
            toSnapshot!.layer.transform = AnimationHelper.yRotation(0.0)
        })
      },
      completion: { _ in
        toVC.view.layer.transform = AnimationHelper.yRotation(0.0)
        fromVC.view.isHidden = false
        snapshot?.removeFromSuperview()
        toSnapshot?.removeFromSuperview()
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
  }
}
