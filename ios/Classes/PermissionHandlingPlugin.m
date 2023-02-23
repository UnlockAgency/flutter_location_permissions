#import "PermissionHandlingPlugin.h"
#if __has_include(<permission_handling/permission_handling-Swift.h>)
#import <permission_handling/permission_handling-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "permission_handling-Swift.h"
#endif

@implementation PermissionHandlingPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPermissionHandlingPlugin registerWithRegistrar:registrar];
}
@end
