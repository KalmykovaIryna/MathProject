//
//  RootViewController.swift
//  MathProject
//
//  Created by Iryna Rarova on 29.08.2022.
//

import UIKit

class RootVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func goToMultiplicationVC() {
        let multiplicationVC = storyboard!.instantiateViewController(withIdentifier: "MultiplicationVC")
        navigationController?.pushViewController(multiplicationVC, animated: true)
    }


}
