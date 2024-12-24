//
//  RegisterViewModel.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation

final class RegisterViewModel {
    
    private let helper = RealmHelper()
    var callback: ((String, String) -> Void)?
    
    func createUser(model: UserModel) {
        let dto = UserDTO()
        
        dto.email = model.email
        dto.fin = model.fin
        dto.user = model.userName
        dto.password = model.password
        
        helper.saveUser(dtoModel: dto)
        callback?(model.email, model.password)
    }    
}
