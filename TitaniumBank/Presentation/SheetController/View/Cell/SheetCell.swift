//
//  SheetCell.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 21.12.24.
//

import Foundation
import UIKit

final class SheetCell: UITableViewCell {
    
    private lazy var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var cellImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var cellPan: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupRestriction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        
        contentView.addSubview(cellView)
        contentView.addSubview(cellImage)
        contentView.addSubview(cellPan)
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellPan.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func setupRestriction() {
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cellView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            cellView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
        
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: cellView.topAnchor),
            cellImage.leftAnchor.constraint(equalTo: cellView.leftAnchor),
            cellImage.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            cellImage.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        NSLayoutConstraint.activate([
            cellPan.topAnchor.constraint(equalTo: cellView.topAnchor),
            cellPan.rightAnchor.constraint(equalTo: cellView.rightAnchor),
            cellPan.leftAnchor.constraint(equalTo: cellImage.rightAnchor, constant: 24),
            cellPan.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ])
  
    }
    
    func configureCell(model: CardProtocol) {
        cellImage.image = UIImage(named: model.cardTypeTitle)
        let allPan = model.numberTitle
        let text = allPan.suffix(4)
        let pan = "**** \(String(text))"
        
        cellPan.text = pan
    }
    
    
}

