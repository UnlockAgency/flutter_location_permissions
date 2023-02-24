//
//  PermissionHandler.swift
//  permission_handling
//
//  Created by Bas van Kuijck on 23/02/2023.
//

import Foundation
import CoreLocation

class PermissionHandler {
    private var handlers: [PermissionHandleable] = []
    
    func handle(method: String, arguments: [String: Any], result: @escaping (FlutterValueType) -> Void) {
        do {
            var arguments = arguments
            guard let service = arguments["service"] as? String else {
                throw PermissionError.missingService
            }
            arguments.removeValue(forKey: "service")
            guard let handler = serviceHandler(fromString: service) else {
                throw PermissionError.unknownService
            }
            try handler.handle(method: method, arguments: arguments) { [weak self] res in
                result(res)
                self?.handlers.removeAll { $0.uuid == handler.uuid }
            }
            handlers.append(handler)
            
        } catch let error as PermissionError {
            result(error.stringValue)
            
        } catch {
            result("ERROR_\(error)")
        }
    }
    
    private func serviceHandler(fromString service: String) -> PermissionHandleable? {
        switch service {
        case "location":
            return LocationPermissionHandler()
        default:
            return nil
        }
    }
}
