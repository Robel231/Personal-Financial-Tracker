C:\Users\Administrator\Music\Personal Financial Tracker>flutter build apk --release

Warning: The plugin sqlite3_flutter_libs requires Android SDK version 35.
For more information about build configuration, see https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.       
One or more plugins require a higher Android SDK version.
Fix this issue by adding the following to C:\Users\Administrator\Music\Personal Financial Tracker\android\app\build.gradle:
android {
  compileSdkVersion 35
  ...
}

One or more plugins require a higher Android NDK version.
Fix this issue by adding the following to C:\Users\Administrator\Music\Personal Financial Tracker\android\app\build.gradle:
android {
  ndkVersion "26.1.10909125"
  ...
}

This application cannot tree shake icons fonts. It has non-constant instances of IconData at the following locations:
  - file:///C:/Users/Administrator/Music/Personal%20Financial%20Tracker/lib/presentation/screens/add_transaction_screen.dart:417:25
  - file:///C:/Users/Administrator/Music/Personal%20Financial%20Tracker/lib/presentation/screens/home_screen.dart:284:23
  - file:///C:/Users/Administrator/Music/Personal%20Financial%20Tracker/lib/presentation/screens/stats_screen.dart:368:15
Target aot_android_asset_bundle failed: Exception: Avoid non-constant invocations of IconData or try to build again with --no-tree-shake-icons. 


FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:compileFlutterBuildRelease'.
> Process 'command 'C:\flutter\bin\flutter.bat'' finished with non-zero exit value 1

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.
> Get more help at https://help.gradle.org.

BUILD FAILED in 4m 57s
Running Gradle task 'assembleRelease'...                          299.1s
Gradle task assembleRelease failed with exit code 1