import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'permissions_platform_interface.dart';

/// An implementation of [PermissionHandlingPlatform] that uses method channels.
class MethodChannelPermissions extends PermissionsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('permissions');

  @override
  Future<String?> getLocationPermissionStatus() async {
    final result = await methodChannel.invokeMethod<String>('location', ['get-permission-status']);
    return result;
  }

  @override
  Future<String?> requestLocationPermission(bool always) async {
    final result = await methodChannel.invokeMethod<String>('location', ['request-permission', always ? "always" : "whenInUse"]);
    return result;
  }
}
