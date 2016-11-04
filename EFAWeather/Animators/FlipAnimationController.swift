//
//  FlipAnimationController.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/21/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit

class FlipAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
  var originFrame = CGRect.zero
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.6
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
    guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
        return
    }
    
    let containerView = transitionContext.containerView
    
    let initialFrame = originFrame
    let finalFrame = transitionContext.finalFrame(for: toVC)
    
    let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
    
    snapshot?.frame = initialFrame
    
    containerView.addSubview(toVC.view)
    if let snapshot = snapshot {
        containerView.addSubview(snapshot)
    }
    toVC.view.isHidden = true
    
    AnimationHelper.perspectiveTransformForContainerView(containerView)
    
    snapshot?.layer.transform = AnimationHelper.yRotation(M_PI_2)
    
    let duration = transitionDuration(using: transitionContext)
    
    UIView.animateKeyframes(
      withDuration: duration,
      delay: 0,
      options: .calculationModeCubic,
      animations: {
        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
          fromVC.view.layer.transform = AnimationHelper.yRotation(-M_PI_2)
        })
        
        UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
          snapshot?.layer.transform = AnimationHelper.yRotation(0.0)
        })
        
        UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
          snapshot?.frame = finalFrame
        })
      },
      completion: { _ in
        toVC.view.isHidden = false
        snapshot?.removeFromSuperview()
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      })
  }
}
