//
//  RegisterController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import UIKit

final class RegisterController: BaseViewController {
    
    private lazy var registerButton: UIButton = {
        let button = ReusableButton(title: "Register", onAction: registerButtonClicked)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [fullnameField, emailField, finCodeField, passwordField])
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()
    
    private lazy var fullnameField: UITextField = {
        let field = ReusableTextField(placeholderTitle: "  Aliyev Ahmadagha", placeholderColor: .lightGray, borderWidth: 1, fieldTextAlignment: .left, cornerRadius: 12)
        return field
    }()
    
    private lazy var emailField: UITextField = {
        let field = ReusableTextField(placeholderTitle: "  ahmadagha@gmail.com", placeholderColor: .lightGray, borderWidth: 1, fieldTextAlignment: .left, cornerRadius: 12)
        return field
    }()
    
    private lazy var passwordField: UITextField = {
        let field = ReusableTextField(placeholderTitle: "  ********", placeholderColor: .lightGray, borderWidth: 1, fieldTextAlignment: .left, cornerRadius: 12, secureText: true)
        return field
    }()
    
    private lazy var finCodeField: UITextField = {
        let field = ReusableTextField(placeholderTitle: "  QWERTY8", placeholderColor: .lightGray, borderWidth: 1, fieldTextAlignment: .left, cornerRadius: 12, capitalizationType: .allCharacters)
        return field
    }()
    
    private let viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
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
        fullnameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        finCodeField.delegate = self
    }
    
    @objc private func registerButtonClicked() {
        
        guard let user = fullnameField.text, let email = emailField.text, let fin = finCodeField.text, let password = passwordField.text, !user.isEmpty, !email.isEmpty, !fin.isEmpty, !password.isEmpty else {
            showMessage(title: "", message: "Fields cannot be empty", actionTitle: "Ok")
            return
        }
        
        guard user.count > 5 else {
            showMessage(title: "", message: "The user's full name must not be less than 5 characters", actionTitle: "Ok")
            return
        }
        
        guard emailField.layer.borderColor == UIColor.green.cgColor else {
            showMessage(title: "", message: "Wrong email format", actionTitle: "Ok")
            return
        }
        
        guard fin.count == 7 else {
            showMessage(title: "", message: "FIN format is incorrect", actionTitle: "Ok")
            return
        }
        
        guard password.count >= 8 else {
            showMessage(title: "", message: "Password cannot be less than 8 characters", actionTitle: "Ok")
            return
        }
        
        let model = UserModel(userName: user, fin: fin, email: email, password: password)
        viewModel.createUser(model: model)
        
        guard let navigation = navigationController else {return}
        navigation.popViewController(animated: true)
    }
    
    override func configureView() {
        super.configureView()
        title = "Register"
        
        view.addSubview(scrollView)
        view.addSubview(registerButton)
        scrollView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        fullnameField.translatesAutoresizingMaskIntoConstraints = false
        finCodeField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48)
        ])
        
        NSLayoutConstraint.activate([
            registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -36),
            registerButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            fullnameField.heightAnchor.constraint(equalToConstant: 36),
            emailField.heightAnchor.constraint(equalToConstant: 36),
            finCodeField.heightAnchor.constraint(equalToConstant: 36),
            passwordField.heightAnchor.constraint(equalToConstant: 36)
        ])
        
    }
}

extension RegisterController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case finCodeField:
            return textField.checkFinCode(range: range, replacementString: string)
        case passwordField:
            return textField.passwordFormat(range: range, replacementString: string)
        case fullnameField:
            return textField.fullnameFormat(range: range, replacementString: string)
        case emailField:
            return textField.checkEmailCount(range: range, replacementString: string)
        default:
            return true
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        switch textField {
        case emailField:
            textField.checkEmailFormat()
            textField.cannotAcceptSpace()
        case passwordField:
            textField.checkPassword()
            textField.cannotAcceptSpace()
        case finCodeField:
            textField.checkFin()
        case fullnameField:
            textField.checkUserFullname()
        default:
            break
        }
    }
}
