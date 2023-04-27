//
//  AnswerButton.swift
//  MathProject
//
//  Created by Iryna Rarova on 31.01.2023.

import UIKit
class AnswerButton: UIButton  {
    var id: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.setTitleColor(UIColor(red: 39.0/255.0, green: 41.0/255.0, blue: 50.0 / 255.0, alpha: 1), for: state)
        self.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)
        let image = UIImage(named: "backgroundForViews")
        if let image = image {
            self.backgroundColor = UIColor(patternImage: image)
        }
    }
    
    func updateButtonColor(button: UIButton, needToUpdateColor: Bool){
        if needToUpdateColor {
            button.setTitleColor(UIColor(red: 39.0/255.0, green: 41.0/255.0, blue: 50.0 / 255.0, alpha: 0.6), for: .normal)
            let image = UIImage(named: "backgroundNotActive")
            if let image = image {
                button.backgroundColor = UIColor(patternImage: image)
            }
        }else {
            button.setTitleColor(UIColor(red: 39.0/255.0, green: 41.0/255.0, blue: 50.0 / 255.0, alpha: 1), for: .normal)
            let image = UIImage(named: "backgroundForViews")
            guard let image = image else { return }
            button.backgroundColor = UIColor(patternImage: image)
            button.contentMode = .scaleAspectFit
        }
    }
}
