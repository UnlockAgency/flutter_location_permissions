//
//  FlutterValueType.swift
//  permissions
//
//  Created by Bas van Kuijck on 24/02/2023.
//

import Foundation

protocol FlutterValueType { }
extension String: FlutterValueType { }
extension Int: FlutterValueType { }
extension Bool: FlutterValueType { }
extension Float: FlutterValueType { }
extension Double: FlutterValueType { }
extension Array: FlutterValueType where Element: FlutterValueType { }
extension Dictionary: FlutterValueType where Key: FlutterValueType, Value: FlutterValueType { }

extension FlutterValueType {
    func transformToFlutterValueType() -> Any {
        if let value = self as? Int {
            return NSNumber(value: value)
            
        } else if let value = self as? Double {
            return NSNumber(value: value)
            
        } else if let value = self as? Float {
            return NSNumber(value: value)
            
        } else {
            return self
        }
    }
}
