//
//  CardModel.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation


struct CardModel {
    let cardNumber: String
    let cardCVC: String
    let cardBalance: Double
    let cardDate: String
    let cardType: String
}

extension CardModel: CardProtocol {
    
    var numberTitle: String {
        cardNumber
    }
    
    var cvcTitle: String {
        cardCVC
    }
    
    var balanceTitle: Double {
        cardBalance
    }
    
    var dateTitle: String {
        cardDate
    }
    
    var cardTypeTitle: String {
        cardType
    }
}
