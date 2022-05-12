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

# 以下 2 つは任意です。実装したい内容に応じてインストール。
# ユーザ認証機能
flutter pub add firebase_auth
# データベース
flutter pub add cloud_firestore

# 「ビジネスロジックを表示ロジックから分離できるようにする」らしい
# 何を言ってるんだ…
flutter pub add provider
```

2. `lib/main.dart` に追記

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
```

## 参考文献

- [Flutter アプリに Firebase を追加する](https://firebase.google.com/docs/flutter/setup?platform=web)
- [Flutter の Firebase を知る](https://firebase.google.com/codelabs/firebase-get-to-know-flutter#0)
