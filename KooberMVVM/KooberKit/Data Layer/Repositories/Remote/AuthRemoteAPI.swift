//
//  AuthRemoteAPI.swift
//  KooberMVVM
//
//  Created by Karim Ezzedine on 06/06/2022.
//

import Foundation
import PromiseKit

public protocol AuthRemoteAPI {
    
  func signIn(username: String, password: String) -> Promise<UserSession>
  func signUp(account: NewAccount) -> Promise<UserSession>
    
}
