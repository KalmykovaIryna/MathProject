//
//  PaymentLogic.swift
//  MathProject
//
//  Created by Iryna Rarova on 24.04.2023.
//

import Foundation
import StoreKit

class PaymentLogic: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    private var products = [SKProduct]()
    var productPrice: NSDecimalNumber?
    var productCurrencySymbol: String?
    let defaults = UserDefaults.standard
    var onPurchaseComplete: (() -> Void)?
    
    enum Products: String, CaseIterable {
        case buyProVersion = "com.myapp.irynaKalmykova.MathProject"
    }
    
    public func restoredPurchase(){
        SKPaymentQueue.default().restoreCompletedTransactions()
        print("restore")
    }
    
    public func fetchProducts(){
        let request = SKProductsRequest(productIdentifiers: Set(Products.allCases.compactMap({$0.rawValue})))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
        guard let product = products.first else {return}
        productPrice = product.price
        productCurrencySymbol = product.priceLocale.currencySymbol ?? "$"
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        guard request is SKProductsRequest else { return }
        print("product fetch request failed")
    }
    
    public func purchase(){
        guard let product = products.first else {return}
        guard SKPaymentQueue.canMakePayments() else {return}
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach({ transaction in
            switch transaction.transactionState {
            case .purchasing:
                break
            case .purchased:
                defaults.set(true, forKey: KeysUserDefaults.proVersionPurchased)
                onPurchaseComplete?()
                break
            case .restored:
                print("purchase restored")
                break
            case .failed:
                break
            case .deferred:
                break
            @unknown default:
                fatalError()
            }
        })
    }
}

    
   



