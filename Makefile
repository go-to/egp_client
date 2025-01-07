ANDROID_ENV_FILE_PATH="android/secret.properties"
IOS_ENV_FILE_PATH="ios/RUNNER/Environment.swift"
ENV_FILE_DEFAULT_EXTENSION=.example

setup:
	flutter clean
	flutter pub get
	if [ ! -e "${ANDROID_ENV_FILE_PATH}" ]; then cp "${ANDROID_ENV_FILE_PATH}"{"${ENV_FILE_DEFAULT_EXTENSION}",}; fi
	if [ ! -e "${IOS_ENV_FILE_PATH}" ]; then cp "${IOS_ENV_FILE_PATH}"{"${ENV_FILE_DEFAULT_EXTENSION}",}; fi
