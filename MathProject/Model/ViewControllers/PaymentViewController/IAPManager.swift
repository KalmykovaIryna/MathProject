//
//  IAPManager.swift
//  MathProject
//
//  Created by Iryna Rarova on 10.02.2023.
//
import StoreKit
import Foundation

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    var products = [SKProduct]()
    var productBeingPurchased: SKProduct?
    var productPrice: NSDecimalNumber?
    
    public func fetchProducts(){
        let request = SKProductsRequest(productIdentifiers: ["com.myapp.irynaKalmykova.MathProject"])
        request.delegate = self
        request.start()
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
        guard let product = products.first else {return}
        productPrice = product.price
//        purches(product: product)
    }
    
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        guard request is SKProductsRequest else { return }
        print("product fetch request failed")
    }
    
    public func purches(product: SKProduct){
        guard SKPaymentQueue.canMakePayments() else {return}
        productBeingPurchased = product
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
                handlePurchased(transaction.payment.productIdentifier)
                break
            case .restored:
                break
            case .failed:
                break
            case .deferred:
                break
            }
        })
    }
    
    func handlePurchased(_ id: String) {
        
    }
}
