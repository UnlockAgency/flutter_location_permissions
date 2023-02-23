# Permissions

## Location

```dart

import 'package:permissions/permissions.dart' as permissions;
import 'package:permissions/src/location/location_permission_status.dart';

// ...
  
Future<void> getAuthorizationStatus() async {
    permissions.Permissions permissions = permissions.Permissions();
	
    final status = await permissions.location.getPermissionStatus();
	
    print("Current status? ${status}");
	
    if (status == LocationPermissionStatus.pending) {
        final newStatus = await permissions.location.requestAlwaysPermission();
        print("New status? ${newStatus}");
    }
}

getAuthorizationStatus();
```