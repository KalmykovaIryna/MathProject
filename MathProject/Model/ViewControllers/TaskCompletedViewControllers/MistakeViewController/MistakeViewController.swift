//
//  MistakeViewController.swift
//  MathProject
//
//  Created by Iryna Rarova on 05.01.2023.
//

import UIKit

class MistakeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mistakeTableView: UITableView!
    
    var mistakes: [String] = []
    var vrongAnswers: [Int] = []
    var correctAnswers: [Int] = []
    
    let identifier = "MistakeTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        mistakeTableView.backgroundColor = .clear
        mistakeTableView.dataSource = self
        mistakeTableView.delegate = self
        mistakeTableView.register(UINib(nibName: "MistakeTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func didTapBackButton(){
        navigationController?.popViewController(animated: true)
    }
}

extension MistakeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mistakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  mistakeTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MistakeTableViewCell else { return UITableViewCell() }
            let wrongAnswer = vrongAnswers[indexPath.row]
            let correctAnswer = correctAnswers[indexPath.row]
            cell.mistakeTextLabel.text = mistakes[indexPath.row]
            cell.vrongAnswerLabel.text = "\(wrongAnswer)"
            cell.correctAnswerLabel.text = "\(correctAnswer)"
            return cell
    }
}
