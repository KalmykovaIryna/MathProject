//
//  BlurView.swift
//  MathProject
//
//  Created by Iryna Rarova on 06.02.2023.
//

import Foundation
import UIKit

class BlurView {
    func applyBlurEffect(blurView: UIView, heightBlurView: CGFloat, widthBlurView: CGFloat) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurView.addSubview(blurEffectView)
//        blurEffectView.frame = CGRect(x: 0, y: 0, width: widthBlurView, height: heightBlurView)
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
