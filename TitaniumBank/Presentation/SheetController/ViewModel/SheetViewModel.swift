//
//  SheetViewModel.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 21.12.24.
//

import Foundation

final class SheetViewModel {
    
    private let helper = RealmHelper()
    
    var currentPan: String?
    
    var callback: ((String) -> Void)?
    
    func getCardModel(index: Int) -> String {
        let cardList = helper.fetchCardData()
        let allPan = cardList[index].numberTitle
        let text = allPan.suffix(4)
        let pan = "**** \(String(text))"
        return pan
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
}
