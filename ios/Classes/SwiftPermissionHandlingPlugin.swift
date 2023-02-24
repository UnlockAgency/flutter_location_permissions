import Flutter
import UIKit

public class SwiftPermissionHandlingPlugin: NSObject, FlutterPlugin {
    private let permissionHandler = PermissionHandler()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "permissions", binaryMessenger: registrar.messenger())
        let instance = SwiftPermissionHandlingPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = (call.arguments as? [String: Any]) ?? [:]
        permissionHandler.handle(method: call.method, arguments: arguments) { response in
            result(response.transformToFlutterValueType())
        }
    }
}
