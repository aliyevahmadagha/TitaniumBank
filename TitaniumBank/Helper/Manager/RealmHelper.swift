//
//  RealmHelper.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    let realm = try! Realm()
    
    func findPath() {
        if let url = realm.configuration.fileURL {
            print(url)
        }
    }
    
    func fetchCardData() -> Results<CardDTO> {
        let cardList = realm.objects(CardDTO.self)
        return cardList
    }
    
    func checkEmail(email: String) -> Bool {
        let realmUserList = realm.objects(UserDTO.self)
        let verifyEmail = realmUserList.contains(where: {$0.email == email})
        if verifyEmail {
            return true
        } else {
            return false
        }
    }
    
    func checkPassword(password: String) -> Bool {
        let realmUserList = realm.objects(UserDTO.self)
        let verifyPassword = realmUserList.contains(where: {$0.password == password})
        if verifyPassword {
            return true
        } else {
            return false
        }
    }
    
    func decreaseBalance(pan: String, amount: Double) {
        let cardList = realm.objects(CardDTO.self)
        
        for i in cardList {
            if i.cardNumber == pan {
                try! realm.write({
                    i.cardBalance -= amount
                })
            }
        }
        
    }
    
    func increaseBalance(pan: String, amount: Double) {
        let cardList = realm.objects(CardDTO.self)
        
        for i in cardList {
            if i.cardNumber == pan {
                print(i.cardNumber)
                try! realm.write({
                    i.cardBalance += amount
                })
            }
        }
    }
    
    func saveCard(dtoModel: CardDTO) {
        do {
            try realm.write {
                realm.add(dtoModel)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveUser(dtoModel: UserDTO) {
        do {
            try realm.write {
                realm.add(dtoModel)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteCard(model: CardDTO) {
        do {
            try realm.write {
                realm.delete(model)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}


