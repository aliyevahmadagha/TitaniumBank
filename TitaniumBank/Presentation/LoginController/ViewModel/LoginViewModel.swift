//
//  LoginViewModel.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation

final class LoginViewModel {

    private let helper = RealmHelper()
    
    func checkUser(email: String, password: String) -> Bool {
        let isLogin = helper.checkUser(email: email, password: password)
        return isLogin
    }
    
}
