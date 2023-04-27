//  MultiplyTrainingViewController.swift
//  MathProject
//  Created by Iryna Rarova on 31.08.2022.
//

import UIKit

class QuizViewController: UIViewController, TaskComletedViewControllerDelegate {
    
    @IBOutlet weak var rootLabel: UILabel!
    @IBOutlet weak var buttonOne: AnswerButton!
    @IBOutlet weak var buttonTwo: AnswerButton!
    @IBOutlet weak var buttonTree: AnswerButton!
    @IBOutlet weak var buttonFour: AnswerButton!
    @IBOutlet var answerButtons: [AnswerButton]!
    var choosenNumbers: [Int]  = []
    var choosenSigns: [MathSignEnum] = []
    var multiplierNumbers: Set<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var resultOfMathAction: Int = 0
    var correctAnswers: [Int] = []
    var vrongAnswers: [Int] = []
    var mistakes: [String] = []
    var convertString = ConvertString()
    var answerButton = AnswerButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTrainingLabel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func childViewControllerResponse(choosenSigns: [MathSignEnum], choosenNumbers: [Int]) {
        self.choosenNumbers = choosenNumbers
        self.choosenSigns = choosenSigns
        multiplierNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        createTrainingLabel()
    }

    private func createAnswerButtons(number: Int, number2: Int, choosenSign: MathSignEnum){
        let randomButton = answerButtons.randomElement()
        guard let randomButton = randomButton else { return }
        let correctResult = choosenSign.calculate(number: number, number2: number2)
        var vrongResults: [Int] = []
        while vrongResults.count < 3 {
            let offset = Int.random(in: -5...5)
            let randomIncorrectResult = abs(correctResult + offset)
            if !vrongResults.contains(randomIncorrectResult) && randomIncorrectResult != correctResult {
                vrongResults.append(randomIncorrectResult)
            }
        }
        randomButton.isEnabled = true
        randomButton.setTitle("\(correctResult)", for: .normal)
        answerButton.updateButtonColor(button: randomButton, needToUpdateColor: false)
        randomButton.id = correctResult
        for (index, button) in answerButtons.filter({ $0 != randomButton }).enumerated() {
            button.isEnabled = true
            button.setTitle("\(vrongResults[index])", for: .normal)
            answerButton.updateButtonColor(button: button, needToUpdateColor: false)
            button.id = vrongResults[index]
            
        }
    }
    
    private func createTrainingLabel(){
        guard !multiplierNumbers.isEmpty else { return goToTaskCompletedVC() }
        let choosenSignsCount = choosenSigns.count
        let choosenNumbersCount = choosenNumbers.count
        let multiplierNumbersCount = multiplierNumbers.count
        let randomMultiplier = multiplierNumbers.randomElement()
        guard let randomMultiplier = randomMultiplier else { return }
            let number = choosenNumbers[multiplierNumbersCount % choosenNumbersCount]
            let sign = choosenSigns[multiplierNumbersCount % choosenSignsCount]
            resultOfMathAction = sign.calculate(number: number, number2: randomMultiplier)
            rootLabel.text = convertString.convertString(sign: sign, number: number, number2: randomMultiplier, isNeedEquals: false)
            createAnswerButtons(number: number, number2: randomMultiplier, choosenSign: sign)
            multiplierNumbers.remove(randomMultiplier)
    }
        
    private func checkAnswer(button: AnswerButton){
        if button.id == resultOfMathAction {
            SoundPlayer.shared.congratulationsSounds(soundCase: SoundCases.correctAnswer)
            createTrainingLabel()
            
        } else {
            answerButton.updateButtonColor(button: button, needToUpdateColor: true)
            vrongAnswers.append(button.id)
            correctAnswers.append(resultOfMathAction)
            let string = rootLabel.text
            guard let string = string else { return }
            mistakes.append(string)
            SoundPlayer.shared.congratulationsSounds(soundCase: SoundCases.wrongAnswer)
            button.isEnabled = false
        }
    }
    
    private func showWorningVC(){
        guard let worningVC = storyboard!.instantiateViewController(withIdentifier: "WorningVC") as? WorningViewController else { return }
            present(worningVC, animated: true)
    }
    
    private func goToTaskCompletedVC(){
        if let taskCompletedVC = storyboard!.instantiateViewController(withIdentifier: "TaskCompletedVC") as? TaskCompletedViewController {
            taskCompletedVC.choosenNumbers = choosenNumbers
            taskCompletedVC.choosenSigns = choosenSigns
            taskCompletedVC.mistakes = mistakes
            taskCompletedVC.correctAnswers = correctAnswers
            taskCompletedVC.vrongAnswers = vrongAnswers
            taskCompletedVC.delegate = self
            navigationController?.pushViewController(taskCompletedVC, animated: true)
        }
    }
    
    @IBAction func didTapMainMenu(){
        guard multiplierNumbers.count == 9 else { return showWorningVC() }
            navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapFirstButton(){
        checkAnswer(button: buttonOne)
    }
    
    @IBAction func didTapSecondButton(){
        checkAnswer(button: buttonTwo)
    }
    
    @IBAction func didTapThirdButton(){
        checkAnswer(button: buttonTree)
    }
    
    @IBAction func didTapFourdButton(){
        checkAnswer(button: buttonFour)
    }
}
