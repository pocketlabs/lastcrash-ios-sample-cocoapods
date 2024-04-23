# LastCrash iOS Sample Application (Installation via CocoaPods)

## SDK Setup Instructions

### Add LastCrash to your Podfile:

```bash
pod 'LastCrash'
```

### Install dependency:

```bash
pod install --repo-update
```

### Initialize SDK:

- Replace `LASTCRASH_API_KEY` with your LastCrash API key.

### **Swift:**

```swift
import LastCrash
...
class AppDelegate: UIResponder, UIApplicationDelegate, LastCrashDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ...
    LastCrash.configure("LASTCRASH_API_KEY")
    LastCrash.enabledLogging()
    LastCrash.setDelegate(self)
    ...
  }

  func lastCrashDidCrash() {
    // logic to handle crash here
    LastCrash.send()
  }

}
```

### **Objective-C:**

AppDelegate.h:

```objectivec
#import <LastCrash/LastCrash.h>
...
@interface AppDelegate : RCTAppDelegate <LastCrashDelegate>
```

AppDelegate.m:

```objectivec
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  ...
  [LastCrash configure:@"LASTCRASH_API_KEY"];
  [LastCrash enabledLogging];
  [LastCrash setDelegate:self];
  ...
}

- (void)lastCrashDidCrash {
  // logic here to handle crash
  [LastCrash send];
}
...
```

## Testing

Run app in `Release` mode with debugging turned off. For best results, run on a physical device, rather than an emulator.

Tap `Test Crash` to trigger a crash.  Then re-run the app and watch the output log for the crash being uploaded.  Go to your LastCrash account to view the crash recording.