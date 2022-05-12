# Flutter + Firebase

## Flutter プロジェクト上で Firebase 初期設定

1. 初期設定

```sh
firebase login
dart pub global activate flutterfire_cli
```

%AppData%\Local\Pub\Cache\bin を環境変数に追加。

```sh
flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add cloud_firestore
flutter pub add provider

dart pub global activate flutterfire_cli

flutterfire configure
```

2. `lib/main.dart` に追記

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
```

## 参考文献

- [Flutter アプリに Firebase を追加する](https://firebase.google.com/docs/flutter/setup?platform=web)
- [Flutter の Firebase を知る](https://firebase.google.com/codelabs/firebase-get-to-know-flutter#0)
