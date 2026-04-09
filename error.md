PS C:\Users\Administrator\Music\Personal Financial Tracker> flutter build apk --release --no-tree-shake-icons
>>

lib/presentation/providers/spending_by_category_provider.dart:13:14: Error: Type 'Category' not found.
    required Category category,
             ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:19:3: Error: Type 'Category' not found.
  Category get category => throw _privateConstructorUsedError;
  ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:36:8: Error: Type 'Category' not found.
      {Category category,
       ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:41:3: Error: Type '$CategoryCopyWith' not found. 
  $CategoryCopyWith<$Res> get category;
  ^^^^^^^^^^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:84:3: Error: Type '$CategoryCopyWith' not found. 
  $CategoryCopyWith<$Res> get category {
  ^^^^^^^^^^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:100:8: Error: Type 'Category' not found.
      {Category category,
       ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:106:3: Error: Type '$CategoryCopyWith' not found.
  $CategoryCopyWith<$Res> get category;
  ^^^^^^^^^^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:156:9: Error: Type 'Category' not found.
  final Category category;
        ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:198:23: Error: Type 'Category' not found.        
      {required final Category category,
                      ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:204:3: Error: Type 'Category' not found.
  Category get category;
  ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.dart:13:14: Error: 'Category' isn't a type.
    required Category category,
             ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:36:8: Error: 'Category' isn't a type.
      {Category category,
       ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:66:18: Error: 'Category' isn't a type.
              as Category,
                 ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:85:12: Error: The method '$CategoryCopyWith' isn't defined for the class '_$CategorySpendingCopyWithImpl<$Res, $Val>'.
 - '_$CategorySpendingCopyWithImpl' is from 'package:personal_financial_tracker/presentation/providers/spending_by_category_provider.dart' ('lib/presentation/providers/spending_by_category_provider.dart').
Try correcting the name to the name of an existing method, or defining a method named '$CategoryCopyWith'.
    return $CategoryCopyWith<$Res>(_value.category, (value) {
           ^^^^^^^^^^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:100:8: Error: 'Category' isn't a type.
      {Category category,
       ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:129:18: Error: 'Category' isn't a type.
              as Category,
                 ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:156:9: Error: 'Category' isn't a type.
  final Category category;
        ^^^^^^^^
lib/presentation/providers/spending_by_category_provider.freezed.dart:198:23: Error: 'Category' isn't a type.
      {required final Category category,
                      ^^^^^^^^
Target kernel_snapshot failed: Exception


FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':app:compileFlutterBuildRelease'.
> Process 'command 'C:\flutter\bin\flutter.bat'' finished with non-zero exit value 1

* Try:
> Run with --stacktrace option to get the stack trace.
> Run with --info or --debug option to get more log output.
> Run with --scan to get full insights.
> Get more help at https://help.gradle.org.

BUILD FAILED in 49s
Running Gradle task 'assembleRelease'...                           51.4s
Gradle task assembleRelease failed with exit code 1