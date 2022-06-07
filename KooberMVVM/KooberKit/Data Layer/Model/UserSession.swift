//
//  UserSession.swift
//  KooberMVVM
//
//  Created by Karim Ezzedine on 06/06/2022.
//

import Foundation

public class UserSession: Codable {
    
    // MARK: - Properties
    public let profile: UserProfile
    public let remoteSession: RemoteUserSession
    
    // MARK: - Methods
    public init(profile: UserProfile, remoteSession: RemoteUserSession) {
        self.profile = profile
        self.remoteSession = remoteSession
    }
}
