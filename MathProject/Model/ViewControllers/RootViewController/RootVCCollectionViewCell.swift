//  RootVCCollectionViewCell.swift
//  MathProject
//  Created by Iryna Rarova on 14.11.2022.
//
import UIKit
class RootVCCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet var arrayOfLabels: [UILabel]!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    static let identifier = "RootVCCollectionViewCell"
    let convertedString = ConvertString()

    override func awakeFromNib() {
        super.awakeFromNib()
        bgImageView.layer.cornerRadius = 20
        stackView.contentMode = .scaleToFill
    }
//    
//    #warning("Use it")
//    func configure(with lines: [String]) {
//        for (index, label) in arrayOfLabels.enumerated() {
//            label.text = lines[index]
//        }
//    }
//    
//    #warning("Remove")

    
    func configureToActiveState(){
        self.isUserInteractionEnabled = true
        self.bgImageView.image = UIImage(named: "backgroundForViews")
        self.bgImageView.layer.borderWidth = 2
        self.bgImageView.layer.borderColor = UIColor(red: 252.0/255.0, green: 241.0/255.0, blue: 80.0 / 255.0, alpha: 1).cgColor
        let buttonImage = UIImage(named: "statusButtonActive")
        self.statusButton.setImage(buttonImage, for: .normal)
        subviews.forEach { $0.alpha = 1.0 }
    }
    
    func configureToNotActiveState(){
        self.isUserInteractionEnabled = true
        self.bgImageView.image = UIImage(named: "backgroundForViews")
        self.bgImageView.layer.borderWidth = 0
        self.bgImageView.layer.borderColor = .none
        let buttonImage = UIImage(named: "statusButtonNotActive")
        self.statusButton.setImage(buttonImage, for: .normal)
        subviews.forEach { $0.alpha = 1.0 }
    }
    
    func configureToBlockState(){
        self.isUserInteractionEnabled = true
        self.bgImageView.image = UIImage(named: "backgroundNotActive")
        self.bgImageView.layer.borderWidth = 0
        self.bgImageView.layer.borderColor = .none
        let buttonImage = UIImage(named: "statusButtonBlocked")
        self.statusButton.setImage(buttonImage, for: .normal)
        subviews.forEach { $0.alpha = 0.5 }
    }
}



