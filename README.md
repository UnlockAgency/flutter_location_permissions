# Permissions

## Location

```dart

import 'package:permissions/permissions.dart';

// ...
  
Future<void> getAuthorizationStatus() async {
    Permissions _permissions = Permissions();
	
    final status = await _permissions.location.getPermissionStatus();
	
    print("Current status? ${status}");
	
    if (status == LocationPermissionStatus.pending) {
        final newStatus = await permissions.location.requestAlwaysPermission();
        print("New status? ${newStatus}");
    }
}

getAuthorizationStatus();
```