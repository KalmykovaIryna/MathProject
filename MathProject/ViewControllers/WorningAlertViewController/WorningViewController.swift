//  WorningAlertViewController.swift
//  MathProject
//  Created by Iryna Rarova on 31.01.2023.
//

import UIKit

class WorningViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var keepPlayingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let dusmissBlurViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapBlurView(_:)))
        blurView.addGestureRecognizer(dusmissBlurViewTapGestureRecognizer)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurView.addSubview(blurEffectView)
        blurEffectView.topAnchor.constraint(equalTo: blurView.topAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor).isActive = true
        keepPlayingButton.layer.cornerRadius = 10
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func tapBlurView(_ sender: UITapGestureRecognizer){
        dismiss(animated: true)
    }
    
    func goToNavigationRootVC(){
        guard let rootVC = storyboard!.instantiateViewController(withIdentifier: "RootVC") as? RootViewController else { return }
            present(rootVC, animated: true)
    }
    
    @IBAction func didTapEndGame(){
        goToNavigationRootVC()
    }
    
    @IBAction func didTapKeepPlaying(){
        dismiss(animated: true)
    }

}
