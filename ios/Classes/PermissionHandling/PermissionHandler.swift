//
//  PermissionHandler.swift
//  permission_handling
//
//  Created by Bas van Kuijck on 23/02/2023.
//

import Foundation
import CoreLocation

class PermissionHandler {
    private var handler: Any?
    
    func handle(method: String, arguments: [Any], result: @escaping (Any) -> Void) {
        let aResult: (Any) -> Void = { res in
            result(res)
        }
        
        let service = method
        var arguments = arguments
        guard let method = arguments.first as? String else {
            result("")
            return
        }
        arguments.removeFirst()
        switch service {
        case "location":
            let locHandler = LocationPermissionHandler()
            handler = locHandler
            locHandler.handle(method: method, arguments: arguments, result: aResult)
        default:
            result("")
        }
    }
}
