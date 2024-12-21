//
//  TabBarController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    fileprivate func setupTabs() {
        
        let homeController = HomeController(viewModel: HomeViewModel())
        let settingsController = SettingsController(viewModel: SettingsViewModel())
        
        let nav1 = UINavigationController(rootViewController: homeController)
        let nav2 = UINavigationController(rootViewController: settingsController)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.circle"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear.badge.checkmark"), tag: 2)
        
        for nav in [nav1, nav2] {
            
            nav.navigationBar.prefersLargeTitles = true
        }
        setViewControllers([nav1, nav2], animated: true)
    }
}
