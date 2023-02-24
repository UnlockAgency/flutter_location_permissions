//
//  PermissionHandleable.swift
//  permissions
//
//  Created by Bas van Kuijck on 24/02/2023.
//

import Foundation

protocol PermissionHandleable {
    func handle(method: String, arguments: [String: Any], result: @escaping (FlutterValueType) -> Void) throws
    var uuid: String { get }
}
