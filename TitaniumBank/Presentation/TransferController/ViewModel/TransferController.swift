//
//  TransferController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import UIKit

final class TransferController: BaseViewController {
    
    //    private lazy var cardTypeImage: UIImageView = {
    //        let image = UIImageView()
    //        return image
    //    }()
    
    private lazy var viewForIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .blue
        return indicator
    }()
    
    private lazy var fromSelectField: UITextField = {
        let text = ReusableTextField(placeholderTitle: " Transfer from this card", placeholderColor: .lightGray, borderWidth: 1, fieldTextAlignment: .left, cornerRadius: 12)
        text.delegate = self
        return text
    }()
    
    private lazy var toSelectField: UITextField = {
        let text = ReusableTextField(placeholderTitle: " Transfer to this card", placeholderColor: .lightGray, borderWidth: 1, fieldTextAlignment: .left, cornerRadius: 12)
        text.delegate = self
        return text
    }()
    
    private lazy var amountField: UITextField = {
        let text = ReusableTextField(placeholderTitle: " Amount", placeholderColor: .lightGray, borderWidth: 1, fieldTextAlignment: .left, cornerRadius: 12)
        text.keyboardType = .numberPad
        text.delegate = self
        return text
    }()
    
    private lazy var sendButton: UIButton = {
        let button = ReusableButton(title: "Send", onAction: sendButtonClicked, bgColor: .lightGray)
        return button
    }()
    
    private let transferViewModel: TransferViewModel
    
    init(viewModel: TransferViewModel) {
        self.transferViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func sendButtonClicked() {
        
        if let fromtext = fromSelectField.text, let toText = toSelectField.text {
            
            guard !fromtext.isEmpty, !toText.isEmpty else {return}
            guard let amount = amountField.text else {return}
            guard let doubleAmount = Double(amount) else {return}
            
            guard transferViewModel.cardType1 == transferViewModel.cardType2 else {
                
                if doubleAmount + 1 > transferViewModel.getBalance(pan: fromtext) {
                    transferViewModel.success?(.error)
                    showMessage(title: "", message: "your balance: \(transferViewModel.getBalance(pan: fromtext)), amount with comission: \(doubleAmount + 1)", actionTitle: "Ok")
                    amountField.text = ""
                } else {
                    
                    transferViewModel.success?(.loading)
                    viewForIndicator.isHidden = false
                    indicatorView.startAnimating()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.transferViewModel.increaseBalance(pan: toText, amount: doubleAmount)
                        self.transferViewModel.decreaseBalance(pan: fromtext, amount: doubleAmount, commission: 1)
                        self.transferViewModel.success?(.loaded)
                        self.indicatorView.stopAnimating()
                        self.viewForIndicator.isHidden = true
                        
                        self.configureFields()
                        self.transferViewModel.success?(.success)
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                return
            }
            
            if doubleAmount > transferViewModel.getBalance(pan: fromtext) {
                
                transferViewModel.success?(.error)
                showMessage(title: "", message: "your balance: \(transferViewModel.getBalance(pan: fromtext))", actionTitle: "Ok")
                amountField.text = ""
                
            } else {
                transferViewModel.success?(.loading)
                viewForIndicator.isHidden = false
                indicatorView.startAnimating()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.transferViewModel.increaseBalance(pan: toText, amount: doubleAmount)
                    self.transferViewModel.decreaseBalance(pan: fromtext, amount: doubleAmount)
                    
                    
                    self.transferViewModel.success?(.loaded)
                    self.indicatorView.stopAnimating()
                    self.viewForIndicator.isHidden = true
                    
                    self.configureFields()
                    self.transferViewModel.success?(.success)
                    
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    fileprivate func configureFields() {
        fromSelectField.text = ""
        toSelectField.text = ""
        amountField.text = ""
    }
    
    fileprivate func showSheet(index: Int) {
        
        let viewModel = SheetViewModel()
        let sheetVC = SheetController(viewModel: viewModel)
        sheetVC.modalPresentationStyle = .pageSheet
        
        switch index {
        case 0:
            viewModel.callback = { [weak self] text, type in
                guard let self = self else {return}
                self.fromSelectField.text = text
                transferViewModel.cardType1 = type
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if self.fromSelectField.text == self.toSelectField.text {
                        self.showMessage(title: "", message: "you cannot select the same cards", actionTitle: "ok")
                        self.fromSelectField.text = ""
                    }
                    
                    guard self.transferViewModel.cardType2 != nil else {return}
                    
                    if self.transferViewModel.cardType1 != self.transferViewModel.cardType2 {
                        self.showMessage(title: "", message: "When transferring between Visa and Mastercard, a commission of 1 AZN is charged", actionTitle: "ok")
                    }
                    
                }
            }
        case 1:
            viewModel.callback = { [weak self] text, type in
                guard let self = self else {return}
                self.toSelectField.text = text
                transferViewModel.cardType2 = type
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if self.fromSelectField.text == self.toSelectField.text {
                        self.showMessage(title: "", message: "you cannot select the same cards", actionTitle: "ok")
                        self.toSelectField.text = ""
                    }
                    
                    guard self.transferViewModel.cardType1 != nil else {return}
                    
                    if self.transferViewModel.cardType2 != self.transferViewModel.cardType1 {
                        self.showMessage(title: "", message: "When transferring between Visa and Mastercard, a commission of 1 AZN is charged", actionTitle: "ok")
                        
                    }
                }
            }
        default:
            break
        }
        
        if let sheetPresentationController = sheetVC.sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.prefersGrabberVisible = true
        }
        present(sheetVC, animated: true)
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(fromSelectField)
        view.addSubview(toSelectField)
        view.addSubview(amountField)
        view.addSubview(sendButton)
        view.addSubview(viewForIndicator)
        viewForIndicator.addSubview(indicatorView)
        
        fromSelectField.translatesAutoresizingMaskIntoConstraints = false
        toSelectField.translatesAutoresizingMaskIntoConstraints = false
        amountField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        viewForIndicator.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        NSLayoutConstraint.activate([
            fromSelectField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            fromSelectField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            fromSelectField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            fromSelectField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            toSelectField.topAnchor.constraint(equalTo: fromSelectField.bottomAnchor, constant: 24),
            toSelectField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            toSelectField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            toSelectField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            amountField.topAnchor.constraint(equalTo: toSelectField.bottomAnchor, constant: 24),
            amountField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            amountField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            amountField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 48),
            sendButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            sendButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        viewForIndicator.fillSuperview()
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: viewForIndicator.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: viewForIndicator.centerYAnchor)
        ])
    }
}

extension TransferController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case fromSelectField:
            showSheet(index: 0)
            return false
        case toSelectField:
            showSheet(index: 1)
            return false
        case amountField:
            return true
            
        default:
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case fromSelectField:
            transferViewModel.cardType1 = nil
        case toSelectField:
            transferViewModel.cardType2 = nil
        default:
            break
        }
    }
}
