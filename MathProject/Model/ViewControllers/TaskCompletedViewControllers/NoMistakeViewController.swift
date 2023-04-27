//  NoMistakeViewController.swift
//  MathProject
//  Created by Iryna Rarova on 06.01.2023.

import UIKit
import AVFoundation

class NoMistakeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SoundPlayer.shared.congratulationsSounds(soundCase: SoundCases.noMistake)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func clickBackButton(){
        dismiss(animated: true)
    }
}
