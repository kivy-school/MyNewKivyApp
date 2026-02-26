OUTPUT_DIR="../../wheels"

# Fix missing system headers (assert.h etc.) — macOS requires explicit SDK sysroot

# CIBW_BUILD_MACOS: "cp313-*"

CIBW_ENVIRONMENT_ANDROID="ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/27.3.13750724"


#export IOSSDKROOT=$(xcrun --show-sdk-path --sdk iphoneos)
#uv run cibuildwheel --platform ios --archs arm64_iphoneos --output-dir "$OUTPUT_DIR"

#export IOSSDKROOT=$(xcrun --show-sdk-path --sdk iphonesimulator)
#uv run cibuildwheel --platform ios --archs x86_64_iphonesimulator --output-dir "$OUTPUT_DIR"

CIBW_BEFORE_ALL_MACOS: ./tools/build_macos_dependencies.sh && ./tools/fix_macos_frameworks.sh
CIBW_ENVIRONMENT_MACOS: KIVY_DEPS_ROOT='./kivy-dependencies' 
CIBW_ENVIRONMENT_MACOS: REPAIR_LIBRARY_PATH='./kivy-dependencies/dist/Frameworks' 
CIBW_ENVIRONMENT_MACOS: MACOSX_DEPLOYMENT_TARGET=10.15
CIBW_ENVIRONMENT_MACOS: SDKROOT=$(xcrun --show-sdk-path)
CIBW_ENVIRONMENT_MACOS: CFLAGS="-isysroot $(xcrun --show-sdk-path)"
CIBW_ENVIRONMENT_MACOS: CPPFLAGS="-isysroot $(xcrun --show-sdk-path)"

uv run cibuildwheel --only cp313-macosx_x86_64 --only cp313-macosx_arm64 --output-dir "$OUTPUT_DIR"
