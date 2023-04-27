//
//  CancelButton.swift
//  MathProject
//
//  Created by Iryna Rarova on 06.02.2023.
//

import UIKit

class CancelButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.titleLabel?.textColor = UIColor(red: 224.0/255.0, green: 68.0/255.0, blue: 53.0/255.0, alpha: 1)
        

    }
}
