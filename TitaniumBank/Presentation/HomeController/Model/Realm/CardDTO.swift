//
//  CardDTO.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation
import RealmSwift

class CardDTO: Object {
    @Persisted var cardNumber: String
    @Persisted var cardCVC: String
    @Persisted var cardBalance: Double
    @Persisted var cardDate: String
    @Persisted var cardType: String
}

extension CardDTO: CardProtocol {
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
