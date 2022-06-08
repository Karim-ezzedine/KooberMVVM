//
//  Enum.swift
//  KooberMVVM
//
//  Created by IDS-MBPR-2015 on 6/7/22.
//

import Foundation

// In a real app, errors would be modeled here.
enum KooberKitError: Error {
  case any
}

enum RemoteAPIError: Error {
    case unknown
    case createURL
    case httpError
}

public enum ErrorPresentation {
    case presenting
    case dismissed
}
