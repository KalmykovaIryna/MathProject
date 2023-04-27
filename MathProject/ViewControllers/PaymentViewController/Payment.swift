//
//  Payment.swift
//  MathProject
//
//  Created by Iryna Rarova on 13.02.2023.
//

import Foundation
import StoreKit

class Payment: SKPaymentTransactionObserver {
    
    var products = [SKProduct]()
    private var productBeingPurchased: SKProduct?
    var productPrice: NSDecimalNumber?
    
    
}
exte
