//
//  LoginController.swift
//  TitaniumBank
//
//  Created by Khalida Aliyeva on 19.12.24.
//

import UIKit

final class LoginController: BaseViewController {
    
    private let helper = RealmHelper()
    
    private lazy var goRegisterButton: UIButton = {
        let button = ReusableButton(title: "Don’t you have an account", onAction: goRegisterButtonClicked, bgColor: .systemBackground, titleColor: .lightGray)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = ReusableButton(title: "Login", onAction: loginButtonClicked)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailField, passwordField])
        stack.axis = .vertical
        stack.spacing = 24
        return stack
    }()
    
    private lazy var emailField: UITextField = {
        let field = ReusableTextField(placeholderTitle: "  ahmadagha@gmail.com", placeholderColor: .lightGray, borderWidth: 1, fieldTextAlignment: .left, cornerRadius: 12)
        return field
    }()
    
    private lazy var passwordField: UITextField = {
        let field = ReusableTextField(placeholderTitle: "  ********", placeholderColor: .lightGray, borderWidth: 1, fieldTextAlignment: .left, cornerRadius: 12)
        return field
    }()

    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper.findPath()
    }
    
    @objc private func loginButtonClicked() {
        if let email = emailField.text, let password = passwordField.text, !email.isEmpty,  !password.isEmpty {
            let isLogin = viewModel.checkUser(email: email, password: password)
            
            if isLogin {
                if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    scene.changeRooterToTabBarController()
                }
            } else {
                
            }
        }
    }
    
    @objc private func goRegisterButtonClicked() {
        
        let viewModel = RegisterViewModel()
        let controller = RegisterController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
        
        viewModel.callback = { [weak self] email, password in
            guard let self = self else {return}
            emailField.text = email
            passwordField.text = password
        }
        
    }
    
    override func configureView() {
        super.configureView()
        title = "Login"
        
        view.addSubview(scrollView)
        view.addSubview(loginButton)
        view.addSubview(goRegisterButton)
        scrollView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        goRegisterButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureRestriction() {
        super.configureRestriction()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -12),
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            emailField.heightAnchor.constraint(equalToConstant: 36),
            passwordField.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            goRegisterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            goRegisterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            goRegisterButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 4),
        ])
        
    }

}

