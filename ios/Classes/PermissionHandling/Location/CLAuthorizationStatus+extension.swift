//
//  CLAuthorizationStatus+extension.swift
//  permissions
//
//  Created by Bas van Kuijck on 24/02/2023.
//

import Foundation
import CoreLocation

extension CLAuthorizationStatus {
    var stringValue: String {
        switch self {
        case .authorizedAlways, .authorized:
            return "authorizedAlways"
            
        case .authorizedWhenInUse:
            return "authorizedWhenInUse"
            
        case .denied, .restricted:
            return "denied"
            
        case .notDetermined:
            return "pending"
            
        @unknown default:
            return "unknown"
        }
    }
}
