//
//  UserSessionRepository.swift
//  KooberMVVM
//
//  Created by Karim Ezzedine on 06/06/2022.
//

import Foundation
import PromiseKit

public protocol UserSessionRepository {
    
    func readUserSession() -> Promise<UserSession?>
    func signUp(newAccount: NewAccount) -> Promise<UserSession>
    func signIn(email: String, password: String) -> Promise<UserSession>
    func signOut(userSession: UserSession) -> Promise<UserSession>
    
}
