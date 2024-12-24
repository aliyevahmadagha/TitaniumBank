//
//  ReusableTextField.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 23.12.24.
//

import Foundation
import UIKit

class ReusableTextField: UITextField {
    private var placeholderTitle: String
    private var placeholderFont: String
    private var placeholderSize: CGFloat
    private var placeholderColor: UIColor
    private var borderColor: UIColor
    private var borderWidth: CGFloat
    private var fieldTextAlignment: NSTextAlignment
    private var cornerRadius: CGFloat
    private var secureText: Bool
    private var capitalizationType: UITextAutocapitalizationType
    
    init(placeholderTitle: String, placeholderFont: String  = "Times New Roman", placeholderSize: CGFloat = 16, placeholderColor: UIColor, borderColor: UIColor = .gray, borderWidth: CGFloat, fieldTextAlignment: NSTextAlignment, cornerRadius: CGFloat = 0, secureText: Bool = false, capitalizationType: UITextAutocapitalizationType = .none) {
        self.capitalizationType = capitalizationType
        self.placeholderTitle = placeholderTitle
        self.placeholderFont = placeholderFont
        self.placeholderSize = placeholderSize
        self.placeholderColor = placeholderColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.fieldTextAlignment = fieldTextAlignment
        self.cornerRadius = cornerRadius
        self.secureText = secureText
        
        super.init(frame: .zero)
        configurePlaceholder()
    }
    
    fileprivate func configurePlaceholder() {
        attributedPlaceholder = NSAttributedString(string: placeholderTitle, attributes: [.foregroundColor: placeholderColor.withAlphaComponent(1), .font: UIFont(name: placeholderFont, size: placeholderSize)!])
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        textColor = placeholderColor
        textAlignment = fieldTextAlignment
        autocapitalizationType = .none
        isSecureTextEntry = secureText
        autocapitalizationType = capitalizationType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
