//  RootViewController.swift
//  MathProject
//  Created by Iryna Rarova on 14.11.2022.

import UIKit
import StoreKit
import CoreMedia

class RootViewController: UIViewController {
    @IBOutlet weak var hourArrow: UIImageView!
    @IBOutlet weak var minuteArrow: UIImageView!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var division: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startButtonBottomConstraint: NSLayoutConstraint!
    
    private var viewHeight: CGFloat { view.bounds.height }
    private var viewWidth: CGFloat { view.bounds.width }
    private var bottomSafeArea: CGFloat?
    private var choosenSigns: [MathSignEnum] = []
    private var choosenNumbers: [Int] = [1]
    private var addMultiplyToArray: Bool = true
    private var addPlusToArray: Bool = false
    private var addMinusToArray: Bool = false
    private var addDivisionToArray: Bool = false
    private var convertedString = ConvertString()
    private var animate = RootViewControllerAnimator()
    private let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "RootVCCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RootVCCollectionViewCell.identifier)
        choosenSigns.append(.multiply)
        calculateBottomSafeArea()
        configureSectionLabel(count: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animate.rotateArrow(imageView: hourArrow, duration: 60)
        animate.rotateArrow(imageView: minuteArrow, duration: 20)
        animate.animate(view: startButton, withDuration: 1, borderWidth: 4)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    private func calculateBottomSafeArea() {
        guard let window = UIApplication
            .shared
            .connectedScenes
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?
            .windows
            .first else { return }
        bottomSafeArea = window.safeAreaInsets.bottom
        guard let bottomSafeArea = bottomSafeArea, bottomSafeArea != 0 else { return startButtonBottomConstraint.constant = 8 }
        startButtonBottomConstraint.constant = bottomSafeArea
    }
    
    private func configureSectionLabel(count: Int){
        let sectionCount = choosenNumbers.count
        sectionLabel.text = "SELECTED SECTION: \(sectionCount)"
        sectionLabel.font = UIFont.init(name: "AvenirNext-Bold", size: 17)
        sectionLabel.textColor = UIColor(red: 252.0/255.0, green: 241.0/255.0, blue: 80.0 / 255.0, alpha: 1)
        
    }
    
    private func sendDataToNavigationGameVC(navigationVC: UINavigationController? ){
        guard let navigationVC = navigationVC?.viewControllers.first as? NavigationGameViewController else { return }
            navigationVC.sings = choosenSigns
            navigationVC.numbers = choosenNumbers
    }
    
    private func sendToPaymentVC(){
        guard let paymentVC = storyboard!.instantiateViewController(withIdentifier: "PaymentVC") as? PaymentViewController else { return }
            paymentVC.updateCellStatus = { [weak self] in
                self?.collectionView.reloadData()}
            present(paymentVC, animated: true)
    }
    
    private func getCellStatus(indexPath: IndexPath) -> CellStatus {
        let proVersionPurchased = defaults.bool(forKey: KeysUserDefaults.proVersionPurchased)
        guard !choosenNumbers.contains(indexPath.row + 1) else { return .active }
        guard !proVersionPurchased else { return .notActive }
        guard indexPath.row < 3 else { return .notPayed }
        return .notActive
    }
    
    private func updateImageForMathActionButton(mathActionButton: UIButton, mathAction: MathSignEnum, addSignToArray: Bool){
        if !addSignToArray {
            mathActionButton.setImage(UIImage(named: "\(mathAction.descriptionText)NotActive"), for: .normal)
            if let index = choosenSigns.firstIndex(of: mathAction) {
                choosenSigns.remove(at: index)
            }
            
        }else {
            mathActionButton.setImage(UIImage(named: "\(mathAction.descriptionText)"), for: .normal)
            choosenSigns.append(mathAction)
        }
    }

    private func updateStartButtonStatus(){
        guard !choosenNumbers.isEmpty else { return startButton.isUserInteractionEnabled = false }
        startButton.isUserInteractionEnabled = true
    }
    
    private func createCell(indexPath: IndexPath, arrayOfLabels: [UILabel]?, choosenSign: [MathSignEnum]){
        let int1 = indexPath.row + 1
        guard let arrayOfLabels = arrayOfLabels else { return }
        for index in 0...arrayOfLabels.count - 1 {
            let int2 = index + 1
            let signCount = choosenSign.count
            var sign: MathSignEnum = .multiply
            if signCount > 0 {
                sign = choosenSign[index % signCount]
            } else {
                sign = .none
            }
            let string = convertedString.convertString(sign: sign, number: int1, number2: int2, isNeedEquals: false)
            arrayOfLabels[index].text = string
        }
    }
    
    @IBAction func didTapMinusSignButton(){
        addMinusToArray = !addMinusToArray
        updateImageForMathActionButton(mathActionButton: minus, mathAction: .minus, addSignToArray: addMinusToArray)
        collectionView.reloadData()
    }
    
    @IBAction func didTapPlusSignButton(){
        addPlusToArray = !addPlusToArray
        updateImageForMathActionButton(mathActionButton: plus, mathAction: .plus, addSignToArray: addPlusToArray)
        collectionView.reloadData()
    }
    
    @IBAction func didTapMultiplySignButton(){
        addMultiplyToArray = !addMultiplyToArray
        updateImageForMathActionButton(mathActionButton: multiply, mathAction: .multiply,
                                       addSignToArray: addMultiplyToArray)
        collectionView.reloadData()
    }
    
    @IBAction func didTapDivisionSignButton(){
        addDivisionToArray = !addDivisionToArray
        updateImageForMathActionButton(mathActionButton: division, mathAction: .division,
                                       addSignToArray: addDivisionToArray)
        collectionView.reloadData()
    }
    
    @IBAction func didTapStartButton(){
        let navigationRoot = storyboard!.instantiateViewController(withIdentifier: "NavigationRoot")
        sendDataToNavigationGameVC(navigationVC: navigationRoot as? UINavigationController)
        present(navigationRoot, animated: true, completion: nil)
    }
}

extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RootVCCollectionViewCell.identifier, for: indexPath) as? RootVCCollectionViewCell else { return UICollectionViewCell() }
        let arrayOfLabels = cell.arrayOfLabels
        let cellStatus = getCellStatus(indexPath: indexPath)
        switch cellStatus {
        case .active:
            cell.configureToActiveState()
            createCell(indexPath: indexPath, arrayOfLabels: arrayOfLabels, choosenSign: choosenSigns)
        case .notActive:
            cell.configureToNotActiveState()
            createCell(indexPath: indexPath, arrayOfLabels: arrayOfLabels, choosenSign: choosenSigns)
        case .notPayed:
            createCell(indexPath: indexPath, arrayOfLabels: arrayOfLabels, choosenSign: choosenSigns)
            cell.configureToBlockState()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height - 20
        let countOfPresentedfCell = 3.5
        let cellWidth = collectionView.bounds.width / countOfPresentedfCell
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RootVCCollectionViewCell else { return }
        let cellStatus = getCellStatus(indexPath: indexPath)
        let number = indexPath.row + 1
        switch cellStatus {
        case .active:
            if let index = choosenNumbers.firstIndex(of: number){
                choosenNumbers.remove(at: index)
                updateStartButtonStatus()
                configureSectionLabel(count: choosenNumbers.count)
                cell.configureToNotActiveState()
            }
        case .notActive:
            choosenNumbers.append(number)
            updateStartButtonStatus()
            configureSectionLabel(count: choosenNumbers.count)
            cell.configureToActiveState()
        case .notPayed:
            sendToPaymentVC()
        }
    }
}
