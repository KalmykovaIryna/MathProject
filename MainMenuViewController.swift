//
//  MainMenuViewController.swift
//  MathProject
//
//  Created by Iryna Rarova on 16.01.2023.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet weak var hourArrow: UIImageView!
    @IBOutlet weak var minuteArrow: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        rotateArrow(imageView: hourArrow, duration: 60)
        rotateArrow(imageView: minuteArrow, duration: 20)
     
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
