//
//  Extension.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import Foundation
import UIKit

extension Double {
    func convertToString() -> String {
        return String(self)
    }
}

extension Int {
    func convertToString() -> String {
        return String(self)
    }
}

extension UITableView {
    private func reuseIndentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }
    
    public func register<T: UITableViewCell>(cell: T.Type) {
        register(T.self, forCellReuseIdentifier: reuseIndentifier(for: cell))
    }
    
    public func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: reuseIndentifier(for: headerFooterView))
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(for type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: reuseIndentifier(for: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell.")
        }
        
        return cell
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for type: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: reuseIndentifier(for: type)) as? T else {
            fatalError("Failed to dequeue footer view.")
        }
        
        return view
    }
}

extension UIViewController {
    func showMessage(
        title: String,
        message: String,
        actionTitle: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    func addSubViews(_ views: UIView ...) {
        views.forEach({addSubview($0)})
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView ...) {
        
    }
}

extension String {
    func isValidPassword() -> Bool {
        count > 8
    }
    
    func isValidEmailMask() -> Bool  {
        count > 5
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        count > 2
    }
}

//MARK: UITextField extension

extension UITextField {
    
    func checkCardType() -> String {
        let currentText = self.text ?? ""
        let firstNum = currentText.first
        switch firstNum {
        case "5", "6", "7", "8", "9":
            return "masterCard"
        case "1", "2", "3", "4":
            return "visaCard"
        default:
            return ""
        }
    }
    
    func checkDate(range: NSRange, replacementString string: String) -> Bool {
        let currentText = self.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.range(of: "^[0-9]{0,2}$", options: .regularExpression) != nil
    }
    
    func checkCVC(range: NSRange, replacementString string: String) -> Bool {
        let currentText = self.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.range(of: "^[0-9]{0,3}$", options: .regularExpression) != nil
    }
    
    func checkCardNumber(range: NSRange, replacementString string: String) -> Bool {
        let currentText = self.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        let digitsOnly = newText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if digitsOnly.count > 16 {
            return false
        }
        
        var formattedText = ""
        for (index, digit) in digitsOnly.enumerated() {
            if index > 0 && index % 4 == 0 {
                formattedText += " "
            }
            formattedText += String(digit)
        }
        
        self.text = formattedText
        return false
    }
    
    func checkMonthDigit() {
        guard let text = self.text, text.count == 1 else { return }
        self.text = "0" + text
    }
    
    func checkMonth() -> Bool {
        guard let text = self.text else {return false}
        
        guard let intValue = Int(text) else {return false}
        
        guard intValue <= 12 else {
            self.text = ""
            return false
        }
        return true
    }
    
    func checkYearDigit() -> Bool{
        
        guard let text = self.text else {return false}
        guard !text.isEmpty else {return true}
        guard let intValue = Int(text) else {return false}
        
        if intValue <= 28 && intValue >= 25 {
            return true
        } else {
            self.text = ""
            return false
        }
    }
    
    func switchTextField(textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func checkFieldCount(number: Int) -> Bool {
        
        guard let text = self.text else {return false}
        guard text.count == number else {return false}
        return true
    }
}
