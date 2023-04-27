//
//  RootViewControllerAnimator.swift
//  MathProject
//
//  Created by Iryna Rarova on 18.01.2023.
//

import Foundation
import UIKit

class RootViewControllerAnimator {
    func animate(view: UIView, withDuration: Double, borderWidth: CGFloat){
        UIView.animate(withDuration: withDuration, delay: 0.0,
                         options: .allowUserInteraction,
                         animations: {
            view.layer.borderWidth = borderWidth
            view.layer.borderColor = UIColor(red: 255.0/255.0, green: 241.0/255.0, blue: 45.0 / 255.0, alpha: 1).cgColor
        },
                         completion: { done in
            if done {
                self.changeBorderColor(view: view, withDuration: withDuration, borderWidth: borderWidth)
            }
        })
    }
    
    func changeBorderColor(view: UIView, withDuration: Double, borderWidth: CGFloat){
        UIButton.animate(withDuration: withDuration,
                         animations: {
            view.layer.borderColor = UIColor(red: 39.0/255.0, green: 41.0/255.0, blue: 50.0 / 255.0, alpha: 1).cgColor
        },
                         completion: { done in
            if done {
                self.animate(view: view, withDuration: withDuration, borderWidth: borderWidth)
            }
    
        })
    }
    
    func rotateArrow(imageView: UIImageView, duration: Double) {
          let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
          rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = duration
          rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        imageView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        imageView.layer.add(rotation, forKey: "rotationAnimation")
      }
}
