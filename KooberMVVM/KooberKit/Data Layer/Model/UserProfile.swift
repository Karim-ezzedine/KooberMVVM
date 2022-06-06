//
//  UserProfile.swift
//  KooberMVVM
//
//  Created by Karim Ezzedine on 06/06/2022.
//

import Foundation

public struct UserProfile: Codable {
  public let name: String
  public let email: String
  public let mobileNumber: String
  public let avatar: URL
}
