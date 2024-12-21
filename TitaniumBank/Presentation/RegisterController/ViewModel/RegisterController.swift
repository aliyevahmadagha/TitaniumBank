//
//  RegisterController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import UIKit

final class RegisterController: BaseViewController {
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGray
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
        let field = UITextField()
        field.layer.borderWidth = 1
        field.placeholder = " Aliyev Ahmadagha"
        return field
    }()
    
    private lazy var emailField: UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.placeholder = " ahmadagha@gmail.com"
        return field
    }()
    
    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.placeholder = " ********"
        return field
    }()
    
    private lazy var finCodeField: UITextField = {
        let field = UITextField()
        field.layer.borderWidth = 1
        field.placeholder = " QWERTY8"
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
        
    }
    
    @objc private func registerButtonClicked() {
        
        if let user = fullnameField.text, let email = emailField.text, let fin = finCodeField.text, let password = passwordField.text, !user.isEmpty, !email.isEmpty, !fin.isEmpty, !password.isEmpty {
            
            let model = UserModel(userName: user, fin: fin, email: email, password: password)
            
            viewModel.createUser(model: model)
            navigationController?.popViewController(animated: true)
            
        } else {
            showMessage(title: "Error", message: "Fields cannot be empty", actionTitle: "Ok")
        }
        
        
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
