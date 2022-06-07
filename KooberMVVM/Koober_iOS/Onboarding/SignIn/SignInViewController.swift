//
//  SignInViewController.swift
//  KooberMVVM
//
//  Created by IDS-MBPR-2015 on 6/7/22.
//

import Foundation
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
}
