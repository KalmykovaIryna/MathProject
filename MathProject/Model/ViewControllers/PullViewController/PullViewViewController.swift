//  TestViewController.swift
//  MathProject
//  Created by Iryna Rarova on 13.09.2022.

import UIKit

final class stackViewLabels: UILabel {
    var id: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.textColor = UIColor(red: 218.0/255.0, green: 215.0/255.0, blue: 198.0 / 255.0, alpha: 1)
//        self.textAlignment = .right
//        self.font = UIFont.init(name: "AvenirNext-Bold", size: 18)
    }
}

class PullViewViewController: UIViewController, TaskComletedViewControllerDelegate {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var topLabelsStackViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightLabelsStackViewConstraint: NSLayoutConstraint!
    @IBOutlet var resultViews: [AnswerView]!
    @IBOutlet var heightConstraints: [NSLayoutConstraint]!
    @IBOutlet var widthConstraints: [NSLayoutConstraint]!
    
    private var count: Int = 0
    private var topSafeArea: CGFloat?
    private var bottomSafeArea: CGFloat?
    private var backButtonHeight: CGFloat { backButton.bounds.height }
    private var mainViewHeight: CGFloat { view.bounds.height }
    private var mainViewWidth: CGFloat { view.bounds.width }
    private var answerNumbers: [Int] = []
    private var labels: [stackViewLabels] = []
    private var correctAnswers: [Int] = []
    private var vrongAnswers: [Int] = []
    var choosenNumbers: [Int] =  []
    var choosenSigns: [MathSignEnum] = []
    private var mathActionResults: [Int] = []
    private var mistakes: [String] = []
    private var multipliers: Set<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    private var zeroFrameToFirstGroup: CGFloat?
    private var zeroFrameToSecondGroup: CGFloat?
    private var answerViewOrigins: [CGPoint] = []
    private var convertedString = ConvertString()
    private var viewAndAdditions = ViewAndAdditions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countTopSafeAreaInsets()
        configureViewsConstraints(heightConstraints: heightConstraints, widthConstraints: widthConstraints)
        createLabelsForStackView()
        createFirstGroupOfAnswerView()
        createSecondGroupOfAnswerView()
        addImage(view: mainView)
        addSpeakBuble(view: mainView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func childViewControllerResponse(choosenSigns: [MathSignEnum], choosenNumbers: [Int]) {
        self.choosenNumbers = choosenNumbers
        self.choosenSigns = choosenSigns
        self.prepareForNewGame()
    }
    
    private func countTopSafeAreaInsets(){
        guard let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first else {return}
        topSafeArea = window.safeAreaInsets.top + 8
        bottomSafeArea = window.safeAreaInsets.bottom + 8
    }
    
    private func configureViewsConstraints(heightConstraints: [NSLayoutConstraint], widthConstraints: [NSLayoutConstraint]){
        let viewsHeight = viewAndAdditions.countViewsHeight(mainViewHeight: mainViewHeight,
                                                           topSafeArea: topSafeArea,
                                                           bottomSafeArea: bottomSafeArea,
                                                           backButtonHeight: backButtonHeight)
        let viewsWidth = viewAndAdditions.countViewsWidth(mainViewWidth: mainViewWidth)
        for constraint in heightConstraints {
            constraint.constant = viewsHeight
        }
        for constraint in widthConstraints {
            constraint.constant = viewsWidth
        }
    }
    
    private func createResultsOfMathAction(number: Int, multiplier: Int, sign: MathSignEnum ){
        let result = sign.calculate(number: number, number2: multiplier)
        mathActionResults.append(result)
        if mathActionResults.count == 8 {
            multipliers.remove(multiplier)
            for multiplier in multipliers {
                mathActionResults.append(sign.calculate(number: number, number2: multiplier))
            }
        }
    }
    
    private func createTagResultView(number: Int, randomMultiplier: Int, index: Int, sign: MathSignEnum){
         let index = index - 1
         resultViews[index].tag = sign.calculate(number: number, number2: randomMultiplier)
     }
    
    private func createIDResultView(number: Int, randomMultiplier: Int, index: Int){
        let index = index - 1
        resultViews[index].id = "\(number).\(randomMultiplier)"
       
    }
    
    private  func createLabelsForStackView() {
        let viewsHeight = viewAndAdditions.countViewsHeight(mainViewHeight: mainViewHeight,
                                                            topSafeArea: topSafeArea,
                                                            bottomSafeArea: bottomSafeArea,
                                                            backButtonHeight: backButtonHeight)
        heightLabelsStackViewConstraint.constant = (viewsHeight * 8) + 35
        labelsStackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
        for i in 1...multipliers.count - 2 {
            let label = stackViewLabels()
//        why do not change in final class
            label.textColor = UIColor(red: 218.0/255.0, green: 215.0/255.0, blue: 198.0 / 255.0, alpha: 1)
            label.textAlignment = .right
            label.font = UIFont.init(name: "AvenirNext-Bold", size: 18)
//
            let signCount =  choosenSigns.count
            let sign = choosenSigns[i % signCount]
            let numberCount = choosenNumbers.count
            let number = choosenNumbers[i % numberCount]
            let randomMultiplier = multipliers.randomElement()
            guard let randomMultiplier = randomMultiplier else {return}
            label.text = convertedString.convertString(sign: sign, number: number, number2: randomMultiplier, isNeedEquals: true)
            label.id = "\(number).\(randomMultiplier)"
            createTagResultView(number: number, randomMultiplier: randomMultiplier, index: i, sign: sign)
            createIDResultView(number: number, randomMultiplier: randomMultiplier, index: i)
            createResultsOfMathAction(number: number, multiplier: randomMultiplier, sign: sign)
            labels.append(label)
            multipliers.remove(randomMultiplier)
            labelsStackView.addArrangedSubview(label)
        }
    }
    
    private func createFirstGroupOfAnswerView(){
        guard let bottomSafeArea = bottomSafeArea else {return}
        let viewsHeight = viewAndAdditions.countViewsHeight(mainViewHeight: mainViewHeight,
                                                            topSafeArea: topSafeArea,
                                                            bottomSafeArea: bottomSafeArea,
                                                            backButtonHeight: backButtonHeight)
        let viewsWidth = viewAndAdditions.countViewsWidth(mainViewWidth: mainViewWidth)
        zeroFrameToFirstGroup = mainViewHeight - viewsHeight - bottomSafeArea
        for index in 0...4{
            let randomNumber = mathActionResults.randomElement()
            guard let zeroFrameToFirstGroup = zeroFrameToFirstGroup, let randomNumber =  randomNumber else {return}
            let view = viewAndAdditions.createView(tag: index, xPosition: 16 + CGFloat(index) * (viewsWidth + 5), yPosition: zeroFrameToFirstGroup, width: viewsWidth, height: viewsHeight)
            viewAndAdditions.createLabelsForView(view: view, text: "\(randomNumber)")
            answerNumbers.append(randomNumber)
            guard let index = mathActionResults.firstIndex(of: randomNumber) else { return }
            mathActionResults.remove(at: index)
            answerViewOrigins.append(view.frame.origin)
            addPanGesture(view: view)
            self.view.addSubview(view)
        }
    }
    
    private func createSecondGroupOfAnswerView(){
        let viewsHeight = viewAndAdditions.countViewsHeight(mainViewHeight: mainViewHeight, topSafeArea: topSafeArea, bottomSafeArea: bottomSafeArea, backButtonHeight: backButtonHeight)
        let viewsWidth = viewAndAdditions.countViewsWidth(mainViewWidth: mainViewWidth)
        for index in 0...4 {
            let randomNumber = mathActionResults.randomElement()
            guard let zeroFrameToFirstGroup = zeroFrameToFirstGroup, let randomNumber =  randomNumber else {return}
            zeroFrameToSecondGroup = zeroFrameToFirstGroup - viewsHeight - 5
            guard let zeroFrameToSecondGroup = zeroFrameToSecondGroup else {return}
            let view = viewAndAdditions.createView(tag: index + 5, xPosition: 16 + CGFloat(index) * (viewsWidth + 5), yPosition: zeroFrameToSecondGroup, width: viewsWidth, height: viewsHeight)
            viewAndAdditions.createLabelsForView(view: view, text: "\(randomNumber)")
            answerNumbers.append(randomNumber)
            guard let index = mathActionResults.firstIndex(of: randomNumber) else { return}
            mathActionResults.remove(at: index)
            answerViewOrigins.append(view.frame.origin)
            addPanGesture(view: view)
            self.view.addSubview(view)
        }
    }
    
    private func checkAnswer(answerNumber: Int, resultOfMultiply: Int) -> Bool {
        var result: Bool = false
            if answerNumber == resultOfMultiply {
                result = true
            }
        return result
    }
    
    private func returnStringByID(id: String){
        for label in labels {
            if label.id == id {
                let string = label.text
                guard let string = string else { return }
                mistakes.append(string)
            }
        }
    }
    
    private func showWorningVC(){
        if let worningVC = storyboard!.instantiateViewController(withIdentifier: "WorningVC") as? WorningViewController {
            present(worningVC, animated: true)
        }
    }
    
    private func checkAnswer(view: UIView){
        let viewAnswerNumber = answerNumbers[view.tag]
        for resultView in resultViews {
            let id = resultView.id
            if view.frame.intersects(resultView.frame){
                if checkAnswer(answerNumber: viewAnswerNumber,
                               resultOfMultiply: resultView.tag){
                    SoundPlayer.shared.congratulationsSounds(soundCase: SoundCases.correctAnswer)
                    count += 1
                    viewAndAdditions.deleteView(view: view)
                    viewAndAdditions.deletelabel(id: id,
                                                 arrayOfLabels: labels)
                    resultView.backgroundColor = .clear
                    return
                }else {
                    returnStringByID(id: id)
                    correctAnswers.append(resultView.tag)
                    vrongAnswers.append(viewAnswerNumber)
                    SoundPlayer.shared.congratulationsSounds(soundCase: SoundCases.vrongAnswer)
                    returnViewToOrigin(view: view)
                }
            }
            if view.frame.intersects(labelsStackView.frame) {
                returnViewToOrigin(view: view)
            }
        }
    }
    
    private func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
    }
    
    private func returnColor(){
        let image = UIImage(named: "backgroundForViews")
        if let image = image {
        for view in resultViews {
            view.backgroundColor = UIColor(patternImage: image)
            }
        }
    }
    
    private func returnViewToOrigin(view: UIView){
        let tag = view.tag
        let fileViewOrigin = answerViewOrigins[tag]
        UIView.animate(withDuration: 0.5, animations: {
            view.frame.origin = fileViewOrigin
        })
    }
    
    private func taskIsCompleted(){
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
    
    private func prepareForNewGame(){
        count = 0
        returnColor()
        multipliers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        createLabelsForStackView()
        createFirstGroupOfAnswerView()
        createSecondGroupOfAnswerView()
    }

    private func addPanGesture(view: UIView){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    private func findImageViewOriginY() -> CGFloat {
        let imageStackViewOrigin = labelsStackView.frame.maxY
        return imageStackViewOrigin
    }
    
    private func addImage(view: UIView){
        let image = UIImage(named: "girlImage")
        let heightStackView = labelsStackView.frame.maxY
        let girlImageViewWidth = mainViewWidth * 0.5
        let girlImageViewHeight = girlImageViewWidth * 1.47
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 16, y: heightStackView, width: girlImageViewWidth, height: girlImageViewHeight)
        view.insertSubview(imageView, at: 0)
    }
    
    private func addSpeakBuble(view: UIView) {
        let image = UIImage(named: "speakBuble")
        let imageViewOrigin = findImageViewOriginY() - 127 / 2
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: imageViewOrigin, width: 157, height: 127)
        let label = viewAndAdditions.createLabel(view: imageView, text: "Pull the correct \n number in the \n answer view", centerY: -20)
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 0
        label.textColor = UIColor(red: 74.0/255.0, green: 140.0/255.0, blue: 192.0 / 255.0, alpha: 1)
        view.insertSubview(imageView, at: 0)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer){
        let fileView = sender.view
        switch sender.state {
        case .began, .changed:
            if let fileView = fileView {
                moveViewWithPan(view: fileView, sender: sender)
            }
        case .ended:
            if let fileView = fileView {
                if count < 7 {
                    checkAnswer(view: fileView)
                } else {
                    checkAnswer(view: fileView)
                    taskIsCompleted()
                }
            }
        case .cancelled, .failed, .possible, .recognized: break
        @unknown default:
            fatalError()
        }
    }
    
    @IBAction func didTapBackButton(_ sender: AnyObject) {
        if count == 0 {
            navigationController?.popViewController(animated: true)
        }
        else {
            showWorningVC()
        }
    }
}
