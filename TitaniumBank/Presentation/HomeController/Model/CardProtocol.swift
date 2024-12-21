//
//  CardProtocol.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 20.12.24.
//

import Foundation

protocol CardProtocol {
    var numberTitle: String {get}
    var cvcTitle: String {get}
    var balanceTitle: Double {get}
    var dateTitle: String {get}
    var cardTypeTitle: String {get}
}
