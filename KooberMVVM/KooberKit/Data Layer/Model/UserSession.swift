//
//  UserSession.swift
//  KooberMVVM
//
//  Created by Karim Ezzedine on 06/06/2022.
//

import Foundation

public class UserSession: Codable {
  public let profile: UserProfile
  public let remoteSession: RemoteUserSession
}
