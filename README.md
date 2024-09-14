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

### Optional Delegate

Setting the delegate is optional.  If you would like to control the logic behind sending crash reports then implement the `LastCrashDelegate` interface and call `setDelegate`.

The `lastCrashDidCrash` method will be called when crash reports are available to send.  This allows you to implement your own logic or ask the user for permission to send crash reports.

`LastCrash.send()` must be called to send the crash reports if the delegate is used.

### Freeze support

A call to `LastCrash.applicationInitialized()` must be made after your app is initialized in order to track freeze (application not responding or ANR) errors.  

The reason this call to `LastCrash.applicationInitialized()` is required is to starting Freeze monitoring only after everything in your app is initialized/loaded so false positives can be avoided.

### Networking support

A call to `LastCrash.addNetworkTrackingToDefaultSession()` must be made to track networking errors and get summarized networking statistics including bytes sent/recieveed and response time.

The call to `LastCrash.addNetworkTrackingToDefaultSession()` will add support to any usage of the default URLSession `URLSession.shared`.

If a custom `URLSession` is used then the `URLSessionConfiguration` used during creation must have the `LastCrashURLProtocol` class configured.

```swift
let configuration = URLSessionConfiguration.default
configuration.protocolClasses = [LastCrashURLProtocol.self] + configuration.protocolClasses!
let myURLSession = URLSession(configuration: configuration)
```

#### **Swift:**

```swift
import LastCrash
...
class AppDelegate: UIResponder, UIApplicationDelegate, LastCrashDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ...
    LastCrash.configure("LASTCRASH_API_KEY")
    LastCrash.enabledLogging()
    LastCrash.setDelegate(self)
    LastCrash.addNetworkTrackingToDefaultSession()
    LastCrash.applicationInitialized()
    ...
  }

  func lastCrashDidCrash() {
    // logic to handle crash here
    LastCrash.send()
  }

}
```

#### **Objective-C:**

AppDelegate.h:

```objectivec
#import <LastCrash/LastCrash.h>
...
@interface AppDelegate : UIResponder <UIApplicationDelegate, LastCrashDelegate>
```

AppDelegate.m:

```objectivec
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  ...
  [LastCrash configure:@"LASTCRASH_API_KEY"];
  [LastCrash enabledLogging];
  [LastCrash setDelegate:self];
  [LastCrash addNetworkTrackingToDefaultSession];
  [LastCrash applicationInitialized];
  ...
}

- (void)lastCrashDidCrash {
  // logic here to handle crash
  [LastCrash send];
}
...
```

## Debugging symbols

LastCrash needs your project's debug symbol (dSYM) files to generate human readable crash reports.  Follow the steps below to automatically upload your app's symbol files on release builds.

1. Open your project's Xcode workspace, then select its project file in the left navigator.
2. From the TARGETS list, select your main build target.
3. Click the Build Settings tab, then complete the following steps so that Xcode produces dSYMs for your builds.
4. Click All, then search for debug information format.
5. Set Debug Information Format to DWARF with dSYM File for all your build types.
6. Click the Build Phases tab, then complete the following steps so that Xcode can process your dSYMs and upload the files.
7. Click add > New Run Script Phase.
    * _Make sure this new Run Script phase is your project's last build phase._
8. Expand the Run Script section and replace `LASTCRASH_API_KEY` with your project's API key:
    * Shell
        * `/bin/sh`
    * Script
        * `$PROJECT_DIR/LastCrash.xcframework/lastcrash-run LASTCRASH_API_KEY`
    * Input files section
        * `${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}`
        * `${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}`
        * `${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist`
        * `$PROJECT_DIR/Pods/LastCrash/LastCrash.xcframework/lastcrash-run`

## Testing

Run app in `Release` mode with debugging turned off. For best results, run on a physical device, rather than a simulator.

Tap `Test Crash` to trigger a crash.  Then re-run the app and watch the output log for the crash being uploaded.  Go to your LastCrash account to view the crash recording.