//
//  MultiplyMistakeViewController.swift
//  MathProject
//
//  Created by Iryna Rarova on 07.09.2022.
//

import UIKit

class MultiplyMistakeViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    var setOfwrongMultiplier: Set<Int> = []
    var number: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(setOfwrongMultiplier)
        createLabels()
        
    }
    func createLabels(){
        let labelCount = setOfwrongMultiplier.count
        if let number = number {
            for multiplier in setOfwrongMultiplier {
                let label = UILabel()
                label.text = "\(number) x \(multiplier) = \(number * multiplier)"
                stackView.addArrangedSubview(label)
            }
        }
        
    }
    
    
    
    
    
}
