//
//  TransferController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import UIKit

final class TransferController: BaseViewController {
    
    private lazy var cardTypeImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var fromSelect: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 1
        text.delegate = self
        return text
    }()
    
    private lazy var toSelect: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 1
        text.delegate = self
        return text
    }()
    
    private lazy var amount: UITextField = {
        let text = UITextField()
        text.layer.borderWidth = 1
        text.keyboardType = .numberPad
        text.delegate = self
        return text
    }()
    
    private let viewModel: TransferViewModel
    
    init(viewModel: TransferViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    fileprivate func showSheet(index: Int) {
        
        let viewModel = SheetViewModel()
        let sheetVC = SheetController(viewModel: viewModel)
        sheetVC.modalPresentationStyle = .pageSheet
        
        switch index {
        case 0:
            viewModel.callback = { text in
                self.fromSelect.text = text
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if self.fromSelect.text == self.toSelect.text {
                        self.showMessage(title: "Error", message: "you cannot select the same cards", actionTitle: "ok")
                        self.fromSelect.text = ""
                    }
                }
                
            }
        case 1:
            viewModel.callback = { text in
                self.toSelect.text = text
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if self.fromSelect.text == self.toSelect.text {
                        self.showMessage(title: "Error", message: "you cannot select the same cards", actionTitle: "ok")
                        self.toSelect.text = ""
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
        
        view.addSubview(fromSelect)
        view.addSubview(toSelect)
        view.addSubview(amount)
        
        fromSelect.translatesAutoresizingMaskIntoConstraints = false
        toSelect.translatesAutoresizingMaskIntoConstraints = false
        amount.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        NSLayoutConstraint.activate([
            fromSelect.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            fromSelect.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            fromSelect.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            fromSelect.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            toSelect.topAnchor.constraint(equalTo: fromSelect.bottomAnchor, constant: 24),
            toSelect.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            toSelect.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            toSelect.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            amount.topAnchor.constraint(equalTo: toSelect.bottomAnchor, constant: 24),
            amount.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            amount.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            amount.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension TransferController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case fromSelect:
            showSheet(index: 0)
            return false
        case toSelect:
            showSheet(index: 1)
            return false
        case amount:
            return true
            
        default:
            return false
        }
    }
}
