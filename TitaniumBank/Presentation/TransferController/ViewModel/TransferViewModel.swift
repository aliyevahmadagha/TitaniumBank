//
//  TransferViewModel.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation

final class TransferViewModel {
    
    private let helper = RealmHelper()
        
    func decreaseBalance(pan: String, amount: Double) {
        helper.decreaseBalance(pan: pan, amount: amount)
    }
    
    func increaseBalance(pan: String, amount: Double) {
        helper.increaseBalance(pan: pan, amount: amount)
    }
    
    func getBalance(pan: String = "", index: Int = 0) -> Double {
        var balance = 0.0
        let cardList = helper.fetchCardData()
        
        for i in cardList {
            if i.cardNumber == pan {
                balance = i.cardBalance
            }
        }
        
        return balance
    }
}
