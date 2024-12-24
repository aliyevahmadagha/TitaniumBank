//
//  LoginViewModel.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation

final class LoginViewModel {

    let helper = RealmHelper()
    
    func checkEmail(email: String) -> Bool {
        let verify = helper.checkEmail(email: email)
        return verify
    }
    
    func checkPassword(password: String) -> Bool {
        let verify = helper.checkPassword(password: password)
        return verify
    }
    
    
    func findPath() {
        helper.findPath()
    }
}
