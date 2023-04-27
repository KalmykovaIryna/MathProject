//  TaskCompletedViewController.swift
//  MathProject
//  Created by Iryna Rarova on 03.01.2023.
//

import UIKit
import AVFoundation

protocol TaskComletedViewControllerDelegate {
     func childViewControllerResponse(choosenSigns: [MathSignEnum],
                                      choosenNumbers: [Int])
}

class TaskCompletedViewController: UIViewController {
    var delegate: TaskComletedViewControllerDelegate?
    var choosenNumbers: [Int] = []
    var choosenSigns: [MathSignEnum] = []
    var mistakes: [String] = []
    var correctAnswers: [Int] = []
    var vrongAnswers: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SoundPlayer.shared.congratulationsSounds(soundCase: SoundCases.taskCompleted)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func goToMistakeVC(){
        guard let mistakeVC = storyboard!.instantiateViewController(withIdentifier: "MistakeVC") as? MistakeViewController else { return }
            mistakeVC.mistakes = mistakes
            mistakeVC.correctAnswers = correctAnswers
            mistakeVC.vrongAnswers = vrongAnswers
            navigationController?.pushViewController(mistakeVC, animated: true)
    }
    
    private func goToNoMistakeVC(){
        guard let noMistakeVC = storyboard!.instantiateViewController(withIdentifier: "NoMistakeVC") as? NoMistakeViewController else { return }
            navigationController?.pushViewController(noMistakeVC, animated: true)
    }
    
    @IBAction func didTapWatchMistake(){
        if mistakes.isEmpty {
            goToNoMistakeVC()
        } else {
            goToMistakeVC()
        }
    }
    
    @IBAction func didTapTryAgain(){
        delegate?.childViewControllerResponse(choosenSigns: choosenSigns, choosenNumbers: choosenNumbers)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapMainMenu(){
        dismiss(animated: true)
    }
}
