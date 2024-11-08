# deobfuscate

A new Flutter project for testing deobfuscation on Firebase crashlytics console.

## Getting Started
1. flutter build apk --release --split-debug-info=build/symbols --obfuscate
2. firebase crashlytics:symbols:upload --app=1:639446248573:android:740cac7296d9d738ed5514 ./build/symbols
3. adb install your/path/to/deobfuscate/build/app/outputs/flutter-apk/app-release.apk
4. Tap all buttons on the app to generate some exceptions
5. Check Firebase crashlytics console
