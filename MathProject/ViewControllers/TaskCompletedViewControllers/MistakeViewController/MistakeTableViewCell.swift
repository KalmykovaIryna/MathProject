//
//  MistakeTableViewCell.swift
//  MathProject
//
//  Created by Iryna Rarova on 05.04.2023.
//

import UIKit

class MistakeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var correctAnswerView: UIView!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var vrongAnswerView: UIView!
    @IBOutlet weak var vrongAnswerLabel: UILabel!
    @IBOutlet weak var mistakeTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        correctAnswerView.layer.cornerRadius = 10
        vrongAnswerView.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
