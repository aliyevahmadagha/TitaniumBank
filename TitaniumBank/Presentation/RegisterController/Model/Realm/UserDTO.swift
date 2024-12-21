//
//  UserDTO.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation
import RealmSwift

class UserDTO: Object {
    @Persisted var user: String?
    @Persisted var fin: String?
    @Persisted var email: String?
    @Persisted var password: String?
}


