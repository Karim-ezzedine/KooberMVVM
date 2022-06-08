//
//  MainViewModel.swift
//  KooberMVVM
//
//  Created by Karim Ezzedine on 08/06/2022.
//

import Foundation
import Combine

public class MainViewModel: SignedInResponder, NotSignedInResponder {
    
    // MARK: - Properties
    @Published public private(set) var view: MainView = .launching
    
    // MARK: - Methods
    public init() {}
    
    public func notSignedIn() {
        view = .onboarding
    }
    
    public func signedIn(to userSession: UserSession) {
        view = .signedIn(userSession: userSession)
    }
}
