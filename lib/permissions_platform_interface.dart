import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'permissions_method_channel.dart';

abstract class PermissionsPlatform extends PlatformInterface {
  /// Constructs a PermissionHandlingPlatform.
  PermissionsPlatform() : super(token: _token);

  static final Object _token = Object();

  static PermissionsPlatform _instance = MethodChannelPermissions();

  /// The default instance of [PermissionHandlingPlatform] to use.
  ///
  /// Defaults to [MethodChannelPermissionHandling].
  static PermissionsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PermissionsPlatform] when
  /// they register themselves.
  static set instance(PermissionsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getLocationPermissionStatus() {
    throw UnimplementedError('getLocationPermissionStatus() has not been implemented.');
  }

  Future<String?> requestLocationPermission(bool always) {
    throw UnimplementedError('requestLocationPermission() has not been implemented.');
  }
}
