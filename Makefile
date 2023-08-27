UNITY_APP=/Applications/Unity/Hub/Editor/2021.3.6f1/Unity.app
BUILD_DIR=Build
TARGET_NAME=SwiftPmPlugin
UNITY_PROJECT_PATH=Examples/UnityExample
ASSET_PATH=Assets/Plugins/SwiftPmPlugin/Plugins

test:
	swift test

all: framework bundle copy package

framework:
	xcodebuild build \
		-scheme ${TARGET_NAME} \
		-configuration Release \
		-sdk iphoneos \
		ENABLE_BITCODE=YES \
		BITCODE_GENERATION_MODE=bitcode \
		OTHER_CFLAGS=-fembed-bitcode \
		BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
		CONFIGURATION_BUILD_DIR=${BUILD_DIR}

bundle:
	xcodebuild \
		-workspace ${TARGET_NAME}.xcworkspace \
		-scheme MacOs${TARGET_NAME} \
		-configuration Release \
		-sdk macosx \
		CONFIGURATION_BUILD_DIR=$(CURDIR)/${BUILD_DIR}

copy:
	cp -r ${BUILD_DIR}/PackageFrameworks/${TARGET_NAME}.framework ${UNITY_PROJECT_PATH}/${ASSET_PATH}/iOS/
#	cp -r ${BUILD_DIR}/MacOs${TARGET_NAME}.bundle ${UNITY_PROJECT_PATH}/${ASSET_PATH}/macOS/

package:
	${UNITY_APP}/Contents/MacOS/Unity \
		-exportPackage ${ASSET_PATH} $(CURDIR)/${BUILD_DIR}/${TARGET_NAME}.unitypackage \
		-projectPath ${UNITY_PROJECT_PATH} \
		-batchmode \
		-nographics \
		-quit
	echo exported ${BUILD_DIR}/${TARGET_NAME}.unitypackage
