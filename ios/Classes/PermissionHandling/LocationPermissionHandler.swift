//
//  LocationPermissionHandler.swift
//  permission_handling
//
//  Created by Bas van Kuijck on 23/02/2023.
//

import Foundation
import CoreLocation

class LocationPermissionHandler: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    private var requestingAlways: Bool?
    private var lastKnownStatus: CLAuthorizationStatus?
    
    private var result: ((Any) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    @objc
    private func didBecomeActive() {
        let status = CLLocationManager.authorizationStatus()
        if lastKnownStatus == status {
            return
        }
        lastKnownStatus = status
        guard let result, status != .notDetermined else {
            return
        }
        
        if (status == .authorizedWhenInUse), requestingAlways == true {
            requestingAlways = nil
            lastKnownStatus = .notDetermined
            locationManager.requestAlwaysAuthorization()
            return
        }
        requestingAlways = nil
        result(stringFromStatus(status))
        self.result = nil
    }
    
    func handle(method: String, arguments: [Any], result: @escaping (Any) -> Void) {
        switch method {
        case "get-permission-status":
            result(getAuthorizationStatus())
        case "request-permission":
            self.result = result
            requestPermission(always: arguments.first as? String == "always")
        default:
            result("")
        }
    }
    
    private func getAuthorizationStatus() -> String {
        return stringFromStatus(CLLocationManager.authorizationStatus())
    }
    
    private func stringFromStatus(_ status: CLAuthorizationStatus) -> String {
        switch status {
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
    
    private func requestPermission(always: Bool) {
        requestingAlways = always
        locationManager.requestWhenInUseAuthorization()
    }
}
