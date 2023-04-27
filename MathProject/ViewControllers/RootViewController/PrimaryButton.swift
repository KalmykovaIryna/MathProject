//
//  StartButton.swift
//  MathProject
//
//  Created by Iryna Rarova on 17.01.2023.
//

import UIKit

class PrimaryButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
        self.backgroundColor = UIColor(red: 255.0/255.0, green: 241.0/255.0, blue: 45.0/255.0, alpha: 1)
    }
}
