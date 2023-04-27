//  NavigationGameViewController.swift
//  MathProject
//  Created by Iryna Rarova on 07.12.2022.
//

import UIKit

final class BackgroundViewForButton: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 247.0/255.0, green: 205.0/255.0, blue: 69.0 / 255.0, alpha: 0.8).cgColor
    }
}

class NavigationGameViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pullVCView: UIView!
    @IBOutlet weak var quizVCView: UIView!
    @IBOutlet weak var pullVCImage: UIButton!
    @IBOutlet weak var quizVCImage: UIButton!
    
    var sings: [MathSignEnum] = []
    var numbers: [Int] = []
  
    override func viewDidLoad(){
        super.viewDidLoad()
        let pullTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPullView(_:)))
        let quizTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapQuizView(_:)))
        pullVCView.addGestureRecognizer(pullTapGestureRecognizer)
        quizVCView.addGestureRecognizer(quizTapGestureRecognizer)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func didTapPullView(_ sender: UITapGestureRecognizer) {
        guard let pullViewVC = storyboard!.instantiateViewController(withIdentifier: "PullViewVC") as? PullViewViewController else { return }
            pullViewVC.choosenSigns = sings
            pullViewVC.choosenNumbers = numbers
            navigationController?.pushViewController(pullViewVC, animated: true)
    }
    
    @objc func didTapQuizView(_ sender: UITapGestureRecognizer) {
        guard let quizViewController = storyboard!.instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController else { return }
            quizViewController.choosenSigns = sings
            quizViewController.choosenNumbers = numbers
            navigationController?.pushViewController(quizViewController, animated: true)
        
    }    

    @IBAction func didTapBackButton(){
        dismiss(animated: true, completion: nil)
    }
}
