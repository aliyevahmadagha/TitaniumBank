//
//  HomeViewModel.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation

final class HomeViewModel {
    
    let helper = RealmHelper()
    
    func getListCount() -> Int {
        let cardList = helper.fetchCardData()
        return cardList.count
    }
    
    func getItem(index: Int) -> CardProtocol {
        let cardList = helper.fetchCardData()
        let item = cardList[index]
        return item
    }
}
