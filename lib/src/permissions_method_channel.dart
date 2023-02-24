import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'permissions_platform_interface.dart';
import 'permissions_service.dart';

/// An implementation of [PermissionHandlingPlatform] that uses method channels.
class MethodChannelPermissions extends PermissionsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('permissions');

  @override
  Future<String?> getPermissionStatus(PermissionService service) async {
    final result = await methodChannel.invokeMethod<String>('get-permission-status', {'service': service.toShortString()});
    return result;
  }

  @override
  Future<String?> requestPermission(PermissionService service, Map<String, dynamic>? metadata) async {
    var useMetadata = metadata ?? Map();
    useMetadata["service"] = service.toShortString();
    final result = await methodChannel.invokeMethod<String>('request-permission', useMetadata);
    return result;
  }
}
