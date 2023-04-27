//
//  ActivityButton.swift
//  MathProject
//
//  Created by Iryna Rarova on 29.03.2023.
//

import UIKit

class ActivityButton: UIButton {
    
        var activityIndicator = UIActivityIndicatorView()
        var isLoading = false {
            didSet {
                updateView()
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupView()
        }
        
        func setupView() {
            activityIndicator.hidesWhenStopped = true
            activityIndicator.color = .black
            activityIndicator.style = .medium
            addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
        }
        
        func updateView() {
            if isLoading {
                activityIndicator.startAnimating()
                titleLabel?.alpha = 0
//                imageView?.alpha = 0
//                // to prevent multiple click while in process
                isEnabled = false
            } else {
                activityIndicator.stopAnimating()
                titleLabel?.alpha = 1
                titleLabel?.text = "BUY PRO VERSION"
                imageView?.alpha = 0
                isEnabled = true
            }
        }

}
