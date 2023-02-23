import 'location_permission_status.dart';
import '../permissions_platform_interface.dart';

class LocationPermissionHandler {
  Future<LocationPermissionStatus> getPermissionStatus() {
    return PermissionsPlatform.instance.getLocationPermissionStatus().then((value) => _getStatusFromString(value));
  }

  Future<LocationPermissionStatus> requestAlwaysPermission() {
    return PermissionsPlatform.instance.requestLocationPermission(true).then((value) => _getStatusFromString(value));
  }

  Future<LocationPermissionStatus> requestWhenInusePermission() {
    return PermissionsPlatform.instance.requestLocationPermission(false).then((value) => _getStatusFromString(value));
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

      default:
        return LocationPermissionStatus.pending;
    }
  }
}
