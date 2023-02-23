import 'permissions_platform_interface.dart';
import 'permission_status.dart';

class Permissions {
  Future<PermissionStatus> getLocationPermissionStatus() {
    return PermissionsPlatform.instance.getLocationPermissionStatus().then((value) => _getStatusFromString(value));
  }

  Future<PermissionStatus> requestLocationPermission(bool always) {
    return PermissionsPlatform.instance.requestLocationPermission(always).then((value) => _getStatusFromString(value));
  }

  PermissionStatus _getStatusFromString(String? string) {
    switch (string) {
      case "authorizedAlways":
        return PermissionStatus.authorizedAlways;

      case "authorizedWhenInUse":
        return PermissionStatus.authorizedWhenInUse;

      case "denied":
      case "restricted":
        return PermissionStatus.denied;

      case "pending":
        return PermissionStatus.pending;

      default:
        return PermissionStatus.unknown;
    }
  }
}
