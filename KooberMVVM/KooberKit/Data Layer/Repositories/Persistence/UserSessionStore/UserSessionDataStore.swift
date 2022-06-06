//
//  UserSessionDataStore.swift
//  KooberMVVM
//
//  Created by Karim Ezzedine on 06/06/2022.
//

import Foundation
import PromiseKit

public protocol UserSessionDataStore {
  
  func readUserSession() -> Promise<UserSession?>
  func save(userSession: UserSession) -> Promise<(UserSession)>
  func delete(userSession: UserSession) -> Promise<(UserSession)>
    
}
