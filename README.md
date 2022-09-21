Session Manager package for Flutter. Supports iOS, Android and MacOS

## Features

Save session related data using SQLite database in flutter.

## Getting started

In your flutter project add the dependency:

```dart
dependencies:
  ...
  session_manager:
```dart

## Usage
```dart
import 'package:session_manager/session_manager.dart';

SessionManager().setString("key","value");

String key = await SessionManager().getString("key");

print("value of key $key");
```dart