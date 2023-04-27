//
//  PrimaryLabel.swift
//  MathProject
//
//  Created by Iryna Rarova on 18.01.2023.
//

import UIKit

class PrimaryLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = UIFont.init(name: "AvenirNext-Bold", size: 20)
        self.textColor = UIColor(red: 39.0/255.0, green: 41.0/255.0, blue: 50.0 / 255.0, alpha: 1)
        
    }
}
