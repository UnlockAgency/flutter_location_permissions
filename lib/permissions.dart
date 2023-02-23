import 'src/location/location_handler.dart';

export 'src/location/location_permission_status.dart' show LocationPermissionStatus;

class Permissions {
  late LocationPermissionHandler location = LocationPermissionHandler();
}
