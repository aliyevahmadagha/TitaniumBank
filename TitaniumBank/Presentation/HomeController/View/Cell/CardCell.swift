//
//  CardCell.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 20.12.24.
//

import UIKit

final class CardCell: UICollectionViewCell {
    
    private lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 25
        image.image = UIImage(named: "cardDesign")
        return image
    }()
    
    private lazy var cardTypeImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var panLabel: UILabel = {
        let label = UILabel()
        label.text = "empty"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "empty"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cvcLabel: UILabel = {
        let label = UILabel()
        label.text = "empty"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "empty"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRestriction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: CardProtocol) {
        panLabel.text = model.numberTitle
        dateLabel.text = model.dateTitle
        cvcLabel.text = model.cvcTitle
        balanceLabel.text = model.balanceTitle.convertToString()
        
        cardTypeImage.image = UIImage(named: model.cardTypeTitle)
    }
    
    fileprivate func setupRestriction() {
        
        contentView.addSubview(cardImage)
        contentView.addSubview(panLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(cvcLabel)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(cardTypeImage)
        
        panLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        cvcLabel.translatesAutoresizingMaskIntoConstraints = false
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardTypeImage.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                panLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
                panLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 44),
                panLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -44),
                panLabel.heightAnchor.constraint(equalToConstant: 36)
            ])
        
        NSLayoutConstraint.activate(
            [
                cvcLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
                cvcLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -44),
                cvcLabel.heightAnchor.constraint(equalToConstant: 24),
                cvcLabel.widthAnchor.constraint(equalToConstant: 48)
            ])
        
        NSLayoutConstraint.activate(
            [
                dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
                dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 44),
                dateLabel.heightAnchor.constraint(equalToConstant: 24)
            ])
 
        NSLayoutConstraint.activate(
            [
                cardImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                cardImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
                cardImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
                cardImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
        
        NSLayoutConstraint.activate(
            [
                balanceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
                balanceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 156),
                balanceLabel.heightAnchor.constraint(equalToConstant: 24),
                balanceLabel.widthAnchor.constraint(equalToConstant: 100)
            ])
        
        NSLayoutConstraint.activate([
            cardTypeImage.bottomAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: -72),
            cardTypeImage.leftAnchor.constraint(equalTo: cardImage.leftAnchor, constant: 24),
            cardTypeImage.heightAnchor.constraint(equalToConstant: 52),
            cardTypeImage.widthAnchor.constraint(equalToConstant: 68)
        ])
    }
}
