//
//  AnswerView.swift
//  MathProject
//
//  Created by Iryna Rarova on 30.01.2023.
//

import UIKit

class AnswerView: UIView {
    var id: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        let image = UIImage(named: "backgroundForViews")
        if let image = image {
            self.backgroundColor = UIColor(patternImage: image)
        }
    }
}
