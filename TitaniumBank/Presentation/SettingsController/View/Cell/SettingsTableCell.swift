//
//  SettingsTableCell.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import UIKit

class SettingsTableCell: UITableViewCell {
    
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupRestriction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabel(item: String) {
        settingsLabel.text = " \(item)"
    }
    
    fileprivate func setupRestriction() {
        contentView.addSubview(settingsLabel)
        
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            settingsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            settingsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            settingsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
