library permissions;

import 'src/permissions_platform_interface.dart';
import 'src/permission_status.dart';

export 'src/permission_status.dart' show PermissionStatus, LocationPermissionStatus;

class Permissions {
  Future<LocationPermissionStatus> getLocationPermissionStatus() {
    return PermissionsPlatform.instance.getLocationPermissionStatus().then((value) => _getStatusFromString(value));
  }

  Future<LocationPermissionStatus> requestLocationPermission(bool always) {
    return PermissionsPlatform.instance.requestLocationPermission(always).then((value) => _getStatusFromString(value));
  }

  LocationPermissionStatus _getStatusFromString(String? string) {
    switch (string) {
      case "authorizedAlways":
        return LocationPermissionStatus.authorizedAlways;

      case "authorizedWhenInUse":
        return LocationPermissionStatus.authorizedWhenInUse;

      case "denied":
      case "restricted":
        return LocationPermissionStatus.denied;

      case "pending":
        return LocationPermissionStatus.pending;

      default:
        return LocationPermissionStatus.unknown;
    }
  }
}
