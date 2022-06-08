//
//  SignInViewController.swift
//  KooberMVVM
//
//  Created by IDS-MBPR-2015 on 6/7/22.
//

import UIKit
import PromiseKit
import Combine

public class SignInViewController : NiblessViewController {
    
    // MARK: - Properties
    let viewModelFactory: SignInViewModelFactory
    let viewModel: SignInViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Methods
    init(viewModelFactory: SignInViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeSignInViewModel()
        super.init()
    }
    
    public override func loadView() {
        self.view = SignInRootView(viewModel: viewModel)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObservers()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        (view as! SignInRootView).configureViewAfterLayout()
    }
    
    func observeErrorMessages() {
        viewModel
            .errorMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.present(errorMessage: errorMessage)
            }
            .store(in: &subscriptions)
    }
}

extension SignInViewController {
    
    func addKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleContentUnderKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleContentUnderKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func removeObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc func handleContentUnderKeyboard(notification: Notification) {
        if let userInfo = notification.userInfo, let keyboardEndFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let convertedKeyboardEndFrame = view.convert(keyboardEndFrame.cgRectValue, from: view.window)
            if notification.name == UIResponder.keyboardWillHideNotification {
                (view as! SignInRootView).moveContentForDismissedKeyboard()
            } else {
                (view as! SignInRootView).moveContent(forKeyboardFrame: convertedKeyboardEndFrame)
            }
        }
    }
}
