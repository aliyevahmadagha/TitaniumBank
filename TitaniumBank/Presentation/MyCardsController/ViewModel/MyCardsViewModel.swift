//
//  MyCardsViewModel.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 20.12.24.
//

import Foundation

protocol CollectionReloadProtocol: AnyObject {
    func reload()
}

final class MyCardsViewModel {
    
    private let helper = RealmHelper()
    
    weak var delegate: CollectionReloadProtocol?
    
    var listener: (() -> Void)?
    
    func renewList() {
        listener?()
    }
    
    func getCount() -> Int {
        let cardList = helper.fetchCardData()
        return cardList.count
    }
    
    func getItem(index: Int) -> CardProtocol {
        let cardList = helper.fetchCardData()
        let item = cardList[index]
        return item
    }
    
    func deleteCard(index: Int) {
        let cardList = helper.fetchCardData()
        
        let item = cardList[index]
        helper.deleteCard(model: item)
        listener?()
    }
    
}
