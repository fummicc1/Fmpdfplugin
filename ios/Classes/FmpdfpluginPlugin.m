#import "FmpdfpluginPlugin.h"
#if __has_include(<fmpdfplugin/fmpdfplugin-Swift.h>)
#import <fmpdfplugin/fmpdfplugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fmpdfplugin-Swift.h"
#endif

@implementation FmpdfpluginPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFmpdfpluginPlugin registerWithRegistrar:registrar];
}
@end
