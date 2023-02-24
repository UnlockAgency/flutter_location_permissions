//
//  PermissionError.swift
//  permissions
//
//  Created by Bas van Kuijck on 24/02/2023.
//

import Foundation

enum PermissionError: String, Error {
    case unknownService
    case missingService
    case invalidMethod
    
    var stringValue: String {
        return "ERROR_PERMISSION_\(rawValue.uppercased())"
    }
}
