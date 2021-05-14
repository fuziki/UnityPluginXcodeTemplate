# Example of Creating a Native Plugin for Unity with Swift

# Package.swift
* SwiftPM library

# Build Framework from SwiftPM

```
swift package generate-xcodeproj --skip-extra-files
xcodebuild -project SwiftPmPlugin.xcodeproj -scheme SwiftPmPlugin-Package -configuration Release -sdk iphoneos CONFIGURATION_BUILD_DIR=.
```

# SwiftPmPlugin.xcworkspace
## NativeExamples
### Example-iOS
* Example SwiftPM library written in Objective-C

### Swift-Example-iOS
* Example SwiftPM library written in Swift

## MacOsSwiftPmPlugin
### MacOsSwiftPmPlugin
* Build macOS Bundle for macOS Unity Native Plugin

# Examples/UnityExample
* Unity project using Native Plugin built from the SwiftPM library
