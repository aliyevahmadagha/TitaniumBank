//
//  BaseViewController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        configureView()
        configureRestriction()
        configureTargets()
    }
    
    open func configureView() {}
    open func configureRestriction() {}
    open func configureTargets() {}
}


