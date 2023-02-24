//
//  LocationPermissionHandler.swift
//  permission_handling
//
//  Created by Bas van Kuijck on 23/02/2023.
//

import Foundation
import CoreLocation

class LocationPermissionHandler: NSObject, CLLocationManagerDelegate, PermissionHandleable {
    
    let uuid = UUID().uuidString
    
    private let locationManager = CLLocationManager()
    private var requestingAlways: Bool?
    private var result: ((FlutterValueType) -> Void)?
    private var didResignActive = false
    private var resignActiveTimer: Timer?
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willResignActive),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    @objc
    private func willResignActive() {
        didResignActive = true
        resignActiveTimer?.invalidate()
        resignActiveTimer = nil
    }
    
    @objc
    private func didBecomeActive() {
        didResignActive = false
        let status = CLLocationManager.authorizationStatus()
        guard result != nil, status != .notDetermined else {
            return
        }
        
        guard status == .authorizedWhenInUse, requestingAlways == true else {
            requestingAlways = nil
            callResult()
            return
        }
        
        // There is no difference between "Allow While Using App" and "Allow Once" (both have status .authorizedWhenInUse)
        // But after selecting "Allow Once" you cannot ask for an always permission.
        // Therefore no dialog will be shown and we will check this after 0.5s.
        resignActiveTimer = Timer(timeInterval: 0.5, target: self, selector: #selector(checkResignActive), userInfo: nil, repeats: false)
        RunLoop.main.add(resignActiveTimer!, forMode: .common)
        requestingAlways = nil
        locationManager.requestAlwaysAuthorization()
    }
    
    @objc
    private func checkResignActive() {
        resignActiveTimer = nil
        /// If the timer actually finishes, the 'allow always' dialog is not shown to the user.
        /// Therefor the user most likely tapped "Allow Once" and the result handler should be called
        if !didResignActive, result != nil, requestingAlways == nil {
            requestingAlways = nil
            callResult()
        }
    }
    
    func handle(method: String, arguments: [String: Any], result: @escaping (FlutterValueType) -> Void) throws {
        self.result = result
        switch method {
        case "get-permission-status":
            callResult()
            
        case "request-permission":
            requestPermission(always: arguments["always"] as? Bool == true)
            
        default:
            throw PermissionError.invalidMethod
        }
    }
    
    private func requestPermission(always: Bool) {
        requestingAlways = always
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func callResult() {
        result?(CLLocationManager.authorizationStatus().stringValue)
        result = nil
    }
}
