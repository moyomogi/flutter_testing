# Flutter + Firebase

## Flutter プロジェクト上で Firebase 初期設定

1. 初期設定

```sh
firebase login
dart pub global activate flutterfire_cli
```

%AppData%\Local\Pub\Cache\bin を環境変数に追加。

```sh
# Flutter プロジェクトディレクトリで
# Firebase を使用できるようにする。
flutterfire configure
# Flutter プロジェクトディレクトリに
# コアプラグインをインストール。
flutter pub add firebase_core
```

2. `lib/main.dart` に追記

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
```

## 参考文献

- [Flutter アプリに Firebase を追加する](https://firebase.google.com/docs/flutter/setup?platform=web)
