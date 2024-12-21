//
//  AddCardController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import UIKit

final class AddCardController: BaseViewController {
    
    private lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cardDesign")
        return image
    }()
    
    private lazy var cardTypeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cardDesign")
        return image
    }()
    
    private lazy var cardStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [monthField, dateLabel])
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    private lazy var panField: UITextField = {
        let textField = UITextField()
        let placeholderText = "**** **** **** ****"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        textField.textColor = .white
        return textField
    }()
    
    private lazy var cvcField: UITextField = {
        let textField = UITextField()
        let placeholderText = "CVC"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        textField.textColor = .white
        return textField
    }()
    
    private lazy var monthField: UITextField = {
        let textField = UITextField()
        let placeholderText = "MM"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        textField.textColor = .white
        return textField
    }()
    
    private lazy var yearField: UITextField = {
        let textField = UITextField()
        let placeholderText = "YY"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        textField.textColor = .white
        return textField
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.textColor = .white
        return label
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    
    private let viewModel: AddCardViewModel
    
    init(viewModel: AddCardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFields()
        
    }
    
    fileprivate func setupFields() {
        panField.delegate = self
        cvcField.delegate = self
        monthField.delegate = self
        yearField.delegate = self
    }
    
    @objc private func submitButtonClicked() {
        
        if let month = monthField.text,
           let year = yearField.text,
           let cvc = cvcField.text,
           let pan = panField.text,
           !pan.isEmpty,
           !month.isEmpty,
           !year.isEmpty,
           !cvc.isEmpty {
            
            guard pan.count == 19 else {
                showMessage(title: "Error", message: "Wrong Pan Format", actionTitle: "Ok")
                return
            }
            
            guard month.count == 2 else {
                showMessage(title: "Error", message: "Wrong Month Format", actionTitle: "Ok")
                return
            }
            
            guard year.count == 2 else {
                showMessage(title: "Error", message: "Wrong Year Format", actionTitle: "Ok")
                return
            }
            
            guard cvc.count == 3 else {
                showMessage(title: "Error", message: "Wrong CVC Format", actionTitle: "Ok")
                return
            }
            
            let date = "\(month) / \(year)"
            var cardType: String = ""
            let balance = 10.0
            
            let firstNum = pan.first
            switch firstNum {
            case "5", "6", "7", "8", "9":
                cardType = "masterCard"
                
            case "1", "2", "3", "4":
                cardType = "visaCard"
                
            default:
                cardType = ""
            }
            
            let newCard = CardModel(cardNumber: pan, cardCVC: cvc, cardBalance: balance, cardDate: date, cardType: cardType)
            
            viewModel.saveCard(model: newCard)
            
            configureUI()
            
        } else {
            showMessage(title: "Error", message: "Fields cannot be empty", actionTitle: "Ok")
        }
    }
    
    fileprivate func configureUI() {
        panField.text = ""
        cvcField.text = ""
        monthField.text = ""
        yearField.text = ""
        cardTypeImage.isHidden = true
    }
    
    override func configureView() {
        super.configureView()
        title = "Add Card"
        
        view.addSubview(cardImage)
        view.addSubview(cardStack)
        view.addSubview(panField)
        view.addSubview(cardTypeImage)
        view.addSubview(cvcField)
        view.addSubview(submitButton)
        view.addSubview(yearField)
        
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        panField.translatesAutoresizingMaskIntoConstraints = false
        cardTypeImage.translatesAutoresizingMaskIntoConstraints = false
        monthField.translatesAutoresizingMaskIntoConstraints = false
        cvcField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        yearField.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        NSLayoutConstraint.activate([
            cardImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            cardImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 48),
            cardImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -48),
            cardImage.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            panField.topAnchor.constraint(equalTo: cardImage.topAnchor, constant: 12),
            panField.leftAnchor.constraint(equalTo: cardImage.leftAnchor, constant: 24),
            panField.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        NSLayoutConstraint.activate([
            cardTypeImage.bottomAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: -48),
            cardTypeImage.leftAnchor.constraint(equalTo: cardImage.leftAnchor, constant: 24),
            cardTypeImage.heightAnchor.constraint(equalToConstant: 48),
            cardTypeImage.widthAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            cardStack.bottomAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: -5),
            cardStack.leftAnchor.constraint(equalTo: cardImage.leftAnchor, constant: 24),
            cardStack.heightAnchor.constraint(equalToConstant: 36),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.widthAnchor.constraint(equalToConstant: 8),
            monthField.widthAnchor.constraint(equalToConstant: 36),
//            yearField.widthAnchor.constraint(equalToConstant: 36),
            yearField.leftAnchor.constraint(equalTo: dateLabel.rightAnchor, constant: 8),
            yearField.bottomAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            cvcField.bottomAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: -5),
            cvcField.heightAnchor.constraint(equalToConstant: 35),
            cvcField.rightAnchor.constraint(equalTo: cardImage.rightAnchor, constant: -24),
            cvcField.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 48),
            submitButton.heightAnchor.constraint(equalToConstant: 35),
            submitButton.rightAnchor.constraint(equalTo: cardImage.rightAnchor, constant: -24),
            submitButton.leftAnchor.constraint(equalTo: cardImage.leftAnchor, constant: 24),
        ])
    }
}

extension AddCardController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == panField {
            let currentText = textField.text ?? ""
            let firstNum = currentText.first
            switch firstNum {
            case "5", "6", "7", "8", "9":
                cardTypeImage.isHidden = false
                cardTypeImage.image = UIImage(named: "masterCard")
                
            case "1", "2", "3", "4":
                cardTypeImage.isHidden = false
                cardTypeImage.image = UIImage(named: "visaCard")
                
                
            default:
                cardTypeImage.isHidden = true
            }
            
            if currentText.count == 19 {
                monthField.becomeFirstResponder()
            }
        }
        
        
        if textField == monthField {
            let currentText = textField.text ?? ""
            
            guard let currentNumber = Int(currentText) else {return}
            if currentNumber > 12 {
                showMessage(title: "Error", message: "wrong month format", actionTitle: "Ok")
                textField.text = ""
            }
        }
        
        if textField == yearField {
            let currentText = textField.text ?? ""
            
            guard let currentNumber = Int(currentText) else {return}
            
            if currentText.count == 2 {
                if currentNumber < 25 {
                    showMessage(title: "Error", message: "wrong year format", actionTitle: "Ok")
                    textField.text = ""
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField  {
            
        case panField:
            //            let currentText = textField.text ?? ""
            //
            //            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            //
            //            return prospectiveText.range(of: "^[0-9]{0,19}$", options: .regularExpression) != nil
            
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            // Strip out all non-digit characters
            let digitsOnly = newText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            
            // Check if the new input exceeds 16 digits
            if digitsOnly.count > 16 {
                return false
            }
            
            // Create the new formatted string with spaces every four digits
            var formattedText = ""
            for (index, digit) in digitsOnly.enumerated() {
                if index > 0 && index % 4 == 0 {
                    formattedText += " "  // Add space before adding the next digit
                }
                formattedText += String(digit)
            }
            
            textField.text = formattedText
            return false  // Return false since we've manually set the text field value
            
            
        case monthField:
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return prospectiveText.range(of: "^[0-9]{0,2}$", options: .regularExpression) != nil
            
        case yearField:
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return prospectiveText.range(of: "^[0-9]{0,2}$", options: .regularExpression) != nil
            
        case cvcField:
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return prospectiveText.range(of: "^[0-9]{0,3}$", options: .regularExpression) != nil
            
        default:
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
            
        case monthField:
            guard let text = textField.text else {return}
            guard text.count == 1 else {return}
            textField.text = "0\(text)"
            
        case yearField:
            guard let text = textField.text else {return}
            guard text.count == 1 else {return}
            textField.text = "0\(text)"
            
            guard let currentNumber = Int(text) else {return}
            if currentNumber < 25 {
                showMessage(title: "Error", message: "wrong year format", actionTitle: "Ok")
                textField.text = ""
            }
            
        default:
            break
        }
    }
}




