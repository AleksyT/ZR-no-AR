//
//  Shake.swift
//  Zombie Run
//
//  Created by Aleksy Tylkowski on 27.08.2017.
//  Copyright © 2017 AleksyTylkowski. All rights reserved.
//

import UIKit

class Shake: CALayer
{
    override init(layer: Any)
    {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    init(view: UIButton)
    {
        super.init()
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 4, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 4, y: view.center.y))
        
        view.layer.add(animation, forKey: "position")
    }
}
