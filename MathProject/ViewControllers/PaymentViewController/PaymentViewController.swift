//
//  PaymentViewController.swift
//  MathProject
//  Created by Iryna Rarova on 06.02.2023.

import UIKit
import StoreKit

class PaymentViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var proVersionButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var updateCellStatus: (() -> Void)?
    let defaults = UserDefaults.standard
    
    private lazy var paymentLogic: PaymentLogic = {
        let logic = PaymentLogic()
        logic.onPurchaseComplete = { [weak self] in
            self?.dismiss(animated: true)
            self?.updateCellStatus?()
        }
        return logic
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        proVersionButton.isEnabled = false
        proVersionButton.titleLabel?.alpha = 0
        let blurTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBlurView(_:)))
        blurView.addGestureRecognizer(blurTapRecognizer)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurView.addSubview(blurEffectView)
        blurEffectView.topAnchor.constraint(equalTo: blurView.topAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: blurView.bottomAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor).isActive = true
        checkProductRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateProVersionButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func didTapBlurView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
  
    private func updateProVersionButton(){
        let productPrice = paymentLogic.productPrice
        let productCurrencySymbol = paymentLogic.productCurrencySymbol
        guard let productPrice = productPrice, let productCurrencySymbol = productCurrencySymbol else { return }
        let titleText = "BUY PRO VERSION \(productPrice) \(productCurrencySymbol)"
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        proVersionButton.isEnabled = true
        proVersionButton.titleLabel?.alpha = 1
        proVersionButton.setTitle(titleText, for: .normal)
    }
    
    private func checkProductRequest() {
        let result = defaults.bool(forKey: KeysUserDefaults.proVersionPurchased)
        guard !result else { return }
        paymentLogic.fetchProducts()
    }
    
    @IBAction func didTapBuyProVersionButton(){
        paymentLogic.purchase()
    }
    
    @IBAction func didTapRestoredPurchase(){
        paymentLogic.restoredPurchase()
    }
}
