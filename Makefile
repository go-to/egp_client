ANDROID_ENV_FILE_PATH=android/secret.properties
IOS_ENV_FILE_PATH=ios/RUNNER/Environment.swift
ENV_FILE_DEFAULT_EXTENSION=.example
PROTOBUF_SRC_PATH=../egp_protobuf/src
GRPC_GEN_PATH=lib/grpc_gen

# firebase project
project=

setup:
	flutter clean
	flutter pub get
	if [ ! -e "${ANDROID_ENV_FILE_PATH}" ]; then cp "${ANDROID_ENV_FILE_PATH}"{"${ENV_FILE_DEFAULT_EXTENSION}",}; fi
	if [ ! -e "${IOS_ENV_FILE_PATH}" ]; then cp "${IOS_ENV_FILE_PATH}"{"${ENV_FILE_DEFAULT_EXTENSION}",}; fi
	(cd ios && pod install)
# e.x.) make setup-firebase project=hogehoge
setup-firebase:
	flutterfire configure --project=${project}
protoc:
	if [ ! -e "${GRPC_GEN_PATH}" ]; then mkdir -p "${GRPC_GEN_PATH}"; fi
	protoc --dart_out=grpc:${GRPC_GEN_PATH} -I ${PROTOBUF_SRC_PATH} ${PROTOBUF_SRC_PATH}/*.proto google/protobuf/timestamp.proto
clean-branch:
	git switch main
	git branch | grep -v "main" | xargs git branch -d
	git pull
build-runner:
	flutter pub run build_runner build --delete-conflicting-outputs
build-app:
	flutter build apk --release && mv build/app/outputs/flutter-apk/app-release.apk ./build/egp.apk
	flutter build ipa && sed -i -e 's|<key>method</key>|<key>destination</key>\n    <string>upload</string>\n    <key>method</key>|' build/ios/ipa/ExportOptions.plist && flutter build ipa --export-options-plist="build/ios/ipa/ExportOptions.plist"
release-note:
	cat release_note.txt > android/fastlane/release_note.txt
	cat release_note.txt > ios/fastlane/release_note.txt
deploy-android:
	(cd android && fastlane android deploy)
deploy-ios:
	(cd ios && fastlane ios deploy)
