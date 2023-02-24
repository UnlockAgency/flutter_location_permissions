enum PermissionService { location }

extension ParseToString on PermissionService {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
