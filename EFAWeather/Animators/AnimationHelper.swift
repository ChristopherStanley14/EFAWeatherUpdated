//
//  AnimationHelper.swift
//  EFAWeather
//
//  Created by Brett Keck on 6/21/16.
//  Copyright © 2016 Eleven Fifty Academy. All rights reserved.
//

import UIKit

struct AnimationHelper {
    static func yRotation(_ angle: Double) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    }
    
    static func perspectiveTransformForContainerView(_ containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
}
