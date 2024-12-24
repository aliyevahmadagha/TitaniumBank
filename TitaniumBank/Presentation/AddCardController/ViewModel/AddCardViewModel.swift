//
//  AddCardViewModel.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation

final class AddCardViewModel {
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
    }
    
    let helper = RealmHelper()
    
    var listener: ((ViewState) -> Void)?
    
    func saveCard(model: CardModel) {
        
        listener?(.loading)
        let dto = CardDTO()
        
        dto.cardNumber = model.cardNumber
        dto.cardBalance = model.cardBalance
        dto.cardCVC = model.cardCVC
        dto.cardDate = model.cardDate
        dto.cardType = model.cardType
        listener?(.loaded)
        helper.saveCard(dtoModel: dto)
        listener?(.success)
    }
    
}
