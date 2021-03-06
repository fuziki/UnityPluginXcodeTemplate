EXPORT_DIRECTORY = .

framework:
	swift package generate-xcodeproj --skip-extra-files
	xcodebuild -project SwiftPmPlugin.xcodeproj -scheme SwiftPmPlugin-Package -configuration Release -sdk iphoneos CONFIGURATION_BUILD_DIR=.

package:
	cd unitypackage-exporter && $(MAKE) package EXPORT_DIRECTORY=$(abspath $(EXPORT_DIRECTORY))
