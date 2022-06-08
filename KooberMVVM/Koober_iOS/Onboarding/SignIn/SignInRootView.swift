//
//  SignInRootView.swift
//  KooberMVVM
//
//  Created by Karim Ezzedine on 08/06/2022.
//

import UIKit
import Combine

class SignInRootView: NiblessView {
    
    // MARK: - Properties
    let viewModel: SignInViewModel
    var subscriptions = Set<AnyCancellable>()
    var hierarchyNotReady = true
    
    let scrollView: UIScrollView = UIScrollView()
    let contentView: UIView = UIView()
    
    lazy var inputStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            emailInputStack,
            passwordInputStack
        ])
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    lazy var emailInputStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailIcon, emailField])
        stack.axis = .horizontal
        return stack
    }()
    
    let emailIcon: UIView = {
        let imageView = UIImageView()
        imageView
            .heightAnchor
            .constraint(equalToConstant: 40)
            .isActive = true
        imageView
            .widthAnchor
            .constraint(equalToConstant: 40)
            .isActive = true
        imageView.image = #imageLiteral(resourceName: "email_icon")
        imageView.contentMode = .center
        return imageView
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.backgroundColor = Color.background
        field.textColor = .white
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()
    
    lazy var passwordInputStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [passwordIcon, passwordField])
        stack.axis = .horizontal
        return stack
    }()
    
    let passwordIcon: UIView = {
        let imageView = UIImageView()
        imageView.heightAnchor
            .constraint(equalToConstant: 40)
            .isActive = true
        imageView.widthAnchor
            .constraint(equalToConstant: 40)
            .isActive = true
        imageView.image = #imageLiteral(resourceName: "password_icon")
        imageView.contentMode = .center
        return imageView
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.textColor = .white
        field.backgroundColor = Color.background
        return field
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Sign In", for: .normal)
        button.setTitle("", for: .disabled)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = Color.darkButtonBackground
        return button
    }()
    
    let signInActivityIndicator: UIActivityIndicatorView  = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero, viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindTextFieldsToViewModel()
        bindViewModelToViews()
    }
    
    func bindTextFieldsToViewModel() {
        bindEmailField()
        bindPasswordField()
    }
    
    func bindEmailField() {
        emailField
            .publisher(for: \.text)
            .map { $0 ?? "" }
            .assign(to: \.email, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindPasswordField() {
        passwordField
            .publisher(for: \.text)
            .map { $0 ?? "" }
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard hierarchyNotReady else {
            return
        }
        
        backgroundColor = Color.background
        constructHierarchy()
        activateConstraints()
        wireController()
        hierarchyNotReady = false
    }
    
    func constructHierarchy() {
        scrollView.addSubview(contentView)
        contentView.addSubview(inputStack)
        contentView.addSubview(signInButton)
        signInButton.addSubview(signInActivityIndicator)
        addSubview(scrollView)
    }
 
    
    func activateConstraints() {
        activateConstraintsScrollView()
        activateConstraintsContentView()
        activateConstraintsInputStack()
        activateConstraintsSignInButton()
        activateConstraintsSignInActivityIndicator()
    }
    
    func wireController() {
        signInButton.addTarget(viewModel, action: #selector(SignInViewModel.signIn), for: .touchUpInside)
    }
    
    func configureViewAfterLayout() {
        resetScrollViewContentInset()
    }
    
    func resetScrollViewContentInset() {
        let scrollViewBounds = scrollView.bounds
        let contentViewHeight = CGFloat(180.0)
        
        var scrollViewInsets = UIEdgeInsets.zero
        scrollViewInsets.top = scrollViewBounds.size.height / 2.0;
        scrollViewInsets.top -= contentViewHeight / 2.0;
        
        scrollViewInsets.bottom = scrollViewBounds.size.height / 2.0
        scrollViewInsets.bottom -= contentViewHeight / 2.0
        
        scrollView.contentInset = scrollViewInsets
    }
    
    func moveContentForDismissedKeyboard() {
        resetScrollViewContentInset()
    }
    
    func moveContent(forKeyboardFrame keyboardFrame: CGRect) {
        var insets = scrollView.contentInset
        insets.bottom = keyboardFrame.height
        scrollView.contentInset = insets
    }
}

// MARK: - Layout
extension SignInRootView {
    
    func activateConstraintsScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let leading = scrollView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        let trailing = scrollView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        let top = scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        let bottom = scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
    
    func activateConstraintsContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let width = contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        let leading = contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        let trailing = contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        let top = contentView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        let bottom = contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        NSLayoutConstraint.activate([width, leading, trailing, top, bottom])
    }
    
    func activateConstraintsInputStack() {
        inputStack.translatesAutoresizingMaskIntoConstraints = false
        let leading = inputStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = inputStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let top = inputStack.topAnchor.constraint(equalTo: contentView.topAnchor)
        NSLayoutConstraint.activate([leading, trailing, top])
    }
    
    func activateConstraintsSignInButton() {
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        let leading = signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let top = signInButton.topAnchor.constraint(equalTo: inputStack.bottomAnchor, constant: 20)
        let bottom = contentView.bottomAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20)
        let height = signInButton.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([leading, trailing, top, bottom, height])
    }
    
    func activateConstraintsSignInActivityIndicator() {
        signInActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let centerX = signInActivityIndicator.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor)
        let centerY = signInActivityIndicator.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor)
        NSLayoutConstraint.activate([centerX, centerY])
    }
}

// MARK: - Dynamic behavior
extension SignInRootView {
    
    func bindViewModelToViews() {
        bindViewModelToEmailField()
        bindViewModelToPasswordField()
        bindViewModelToSignInButton()
        bindViewModelToSignInActivityIndicator()
    }
    
    func bindViewModelToEmailField() {
        viewModel
            .$emailInputEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: emailField)
            .store(in: &subscriptions)
    }
    
    func bindViewModelToPasswordField() {
        viewModel
            .$passwordInputEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: passwordField)
            .store(in: &subscriptions)
    }
    
    func bindViewModelToSignInButton() {
        viewModel
            .$signInButtonEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: signInButton)
            .store(in: &subscriptions)
    }
    
    func bindViewModelToSignInActivityIndicator() {
        viewModel
            .$signInActivityIndicatorAnimating
            .receive(on: DispatchQueue.main)
            .sink { [weak self] animating in
                switch animating {
                case true: self?.signInActivityIndicator.startAnimating()
                case false: self?.signInActivityIndicator.stopAnimating()
                }
            }
            .store(in: &subscriptions)
    }
}
