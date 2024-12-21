//
//  SettingsViewModel.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation

final class SettingsViewModel {
    
    var settingsList: [String] = ["Log out", "My cards"]
    
    func getCount() -> Int {
        settingsList.count
    }
    
    func getItem(index: Int) -> String {
        return settingsList[index]
    }
    
}
