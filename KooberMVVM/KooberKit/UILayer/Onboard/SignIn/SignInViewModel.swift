//
//  SignInViewModel.swift
//  KooberMVVM
//
//  Created by IDS-MBPR-2015 on 6/7/22.
//

import Foundation
import PromiseKit
import Combine

public class SignInViewModel {
    
    // MARK: - Properties
    let userSessionRepository: UserSessionRepository
    let signedInResponder: SignedInResponder
    
    // MARK: - Methods
    public init(userSessionRepository: UserSessionRepository, signedInResponder: SignedInResponder) {
        self.userSessionRepository = userSessionRepository
        self.signedInResponder = signedInResponder
    }
    
    public var email = ""
    public var password: Secret = ""
    
    
    // MARK: - Publishers
    public var errorMessagePublisher: AnyPublisher<ErrorMessage, Never> {
        errorMessagesSubject.eraseToAnyPublisher()
    }
    
    private let errorMessagesSubject = PassthroughSubject<ErrorMessage, Never>()
    
    @Published public private(set) var emailInputEnabled = true
    @Published public private(set) var passwordInputEnabled = true
    @Published public private(set) var signInButtonEnabled = true
    @Published public private(set) var signInActivityIndicatorAnimating = false
    
    // MARK: - Task Methods
    
    @objc public func signIn() {
        indicateSigningIn()
        userSessionRepository.signIn(email: email, password: password)
            .done(signedInResponder.signedIn(to:))
            .catch(indicateErrorSigningIn)
    }
    
    func indicateSigningIn() {
        emailInputEnabled = false
        passwordInputEnabled = false
        signInButtonEnabled = false
        signInActivityIndicatorAnimating = true
    }
    
    func indicateErrorSigningIn(_ error: Error) {
        errorMessagesSubject.send(ErrorMessage(title: "Sign In Failed", message: "Could not sign in.\nPlease try again."))
        emailInputEnabled = true
        passwordInputEnabled = true
        signInButtonEnabled = true
        signInActivityIndicatorAnimating = false
    }
}
