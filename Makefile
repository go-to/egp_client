ANDROID_ENV_FILE_PATH="android/secret.properties"
IOS_ENV_FILE_PATH="ios/RUNNER/Environment.swift"
ENV_FILE_DEFAULT_EXTENSION=".example"
PROTOBUF_SRC_PATH="../egp_protobuf/src"
GRPC_GEN_PATH="lib/grpc_gen"

setup:
	flutter clean
	flutter pub get
	if [ ! -e "${ANDROID_ENV_FILE_PATH}" ]; then cp "${ANDROID_ENV_FILE_PATH}"{"${ENV_FILE_DEFAULT_EXTENSION}",}; fi
	if [ ! -e "${IOS_ENV_FILE_PATH}" ]; then cp "${IOS_ENV_FILE_PATH}"{"${ENV_FILE_DEFAULT_EXTENSION}",}; fi
protoc:
	if[ ! -e "${GRPC_GEN_PATH}" ]; mkdir -p "${GRPC_GEN_PATH}" then fi
	protoc --dart_out=grpc:${GRPC_GEN_PATH} -I ${PROTOBUF_SRC_PATH} ${PROTOBUF_SRC_PATH}/*.proto google/protobuf/timestamp.proto
