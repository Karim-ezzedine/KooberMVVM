//
//  SignInViewModelFactory.swift
//  KooberMVVM
//
//  Created by Karim Ezzedine on 08/06/2022.
//

import Foundation

protocol SignInViewModelFactory {
    func makeSignInViewModel() -> SignInViewModel
}
