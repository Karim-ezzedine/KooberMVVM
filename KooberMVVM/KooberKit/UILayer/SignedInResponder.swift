//
//  SignedInResponder.swift
//  KooberMVVM
//
//  Created by IDS-MBPR-2015 on 6/7/22.
//

import Foundation

public protocol SignedInResponder {
    func signedIn(to userSession: UserSession)
}
