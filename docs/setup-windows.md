# Flutter 環境構築 for Windows

<img src="https://i.imgur.com/xelxZnv.png" title="hoshino" width="180">

## 0. 緒言

- Web アプリ作るだけなら、WSL に入れれば容量食わないです。  
  しかし、Android アプリを作るなら、  
  Android Studio を入れた方がいいね。  
  Android Studio の機能のうち使うのは以下の通りです。

  - Android エミュレーターをインストール・起動する。
  - SDK Manager を使って Android SDK を導入。  
    (SDK Manager を利用すると、使用中のドライバが  
    古くなったときに通知が届くので、  
    常に最新のドライバを利用できます。)

- IDE に関しては Android Studio で完結することも可能なんですが、  
  よもぎは VSCode が好きなので VSCode で。
- Flutter で作ったアプリは以下の環境で起動可能です。
  - Web sites
  - Mobile applications (Android, iOS)
  - Desktop applications (Windows, Mac OS, Linux)

## 1. 共通設定

### 1-1. `flutter` のインストール

1. コマンドプロンプトにて。`git clone` する。

```bat
git clone https://github.com/flutter/flutter.git -b stable
```

2. `win + s` で検索窓を出す。  
   env と打って、「環境変数を編集」を押す。
3. 出てきたウィンドウある 2 枠のうち、上の方の枠に Path があるのでダブルクリック。  
   出てきたウィンドウにて、`D:\sys\flutter\bin` を追記。

```cmd
where flutter dart
```

- TODO: `4-1.`, `4-2.` も共通要件かも？

## 2. Web Application を作る

<img src="https://github.com/moyomogi/flutter_testing/raw/master/docs/imgs/suggestion-web.jpg" title="suggestion-web" height="280">

### 2-1. Web Application を起動

1. VSCode の右下で Device を `Chrome (web-javascript)` に変更。
2. `lib/main.dart` 上で `f5` を押すと起動する。

### 2-2. (今回は飛ばす) Web Application を Firebase Hosting にデプロイ

[Firebase 用 Github Actions 設定 | [Flutter] カウンターアプリを Firebase Hosting で Web アプリとして動かす](https://runble1.com/flutter-firebase-hosting-github-actions/#toc6)
本来は、まず Firebase プロジェクトを作成するんですが、  
僕のプロジェクトを共用しようかなと思います。

1. インストール

```sh
npm install -g firebase-tools
firebase login
firebase projects:list
firebase init
```

2. デプロイする。  
   僕の場合は: [Flutter Demo](https://fluttertesting-63ba1.web.app/#/)

```sh
firebase deploy -m "First deploy"
```

## 3. (任意、容量大きい) Windows desktop development のための追加要件

<img src="https://github.com/moyomogi/flutter_testing/raw/master/docs/imgs/suggestion-windows.jpg" title="suggestion-windows" height="280">

### 3-1. Visual Studio Community をインストール

[Visual Studio 2022 Community](https://visualstudio.microsoft.com/ja/downloads/) からインストール。  
ただし、インストール時に `Desktop development with C++` というワークロードが必要。

### 3-2. Windows Application を起動

1. VSCode の右下で Device を `Windows (windows-x64)` に変更。
2. `lib/main.dart` 上で `f5` を押すだけ。

## 4. (任意) Android Application を作る

### 4-1. Android Studio をインストール

1. [Download Android Studio](https://developer.android.com/studio/?hl=ja&authuser=1#downloads) から  
   `android-studio-2021.1.1.23-windows.exe` (2021.1.1.23 部分は  
   2022-04-30 時点のものです。) をダウンロード。

2. exe を起動し、`D:\sys\Android\Android Studio` (D:\sys\ の部分はご自由に。) にインストール。  
   ラジオボタンが 3 個あるので、Decline -> Accept と変更する。

### 4-2. Android SDK を導入

1. Android Studio を起動し、`Customize` > `All settings...`
2. `Appearance & Behavior` > `System Settings` > `Android SDK` を開く。
3. `SDK Tools` タブを開く。
4. 以下にチェックを入れて OK する。

- Android SDK Command-line Tools (latest)
- Android Emulator
- Android SDK Platform-Tools
- Google USB Driver

5. パスを通すため、PowerShell にて以下を実行。

```ps1
# パスを通す。このパスに Java SDK があります。
flutter config --android-studio-dir "D:\sys\Android\Android Studio"
```

```ps1
# ライセンスに yes する。 (Java SDK が必要)
flutter doctor --android-licenses
```

6. `C:\Users\USER_NAME\AppData\Local\Android\Sdk\platforms\android-31\android.jar` がなければ、  
   `C:\Users\USER_NAME\AppData\Local\Android\Sdk\platforms\android-32\android.jar` を  
   `C:\Users\USER_NAME\AppData\Local\Android\Sdk\platforms\android-31\android.jar` に貼り付け。

### 4-3A. Android 実機上で起動

<img src="https://github.com/moyomogi/flutter_testing/raw/master/docs/imgs/suggestion-physical-android.jpg" title="suggestion-physical-android" width="160">

もし、実機で Android スマホを持っていれば、Android 上で Flutter で作ったアプリを動かせます。

#### 4-3A-1. Android 実機の設定

1. `設定` > `端末情報` にて `ビルド番号` を 7 回ぐらいタップします。  
   「これでデベロッパーになりました！」と表示されれば OK です。
2. Android にて `設定` > `システム` > `詳細設定` > `開発者向けオプション`  
   を開き、`USB デバッグ` を ON にしましょう。  
   `$ flutter devices` で自分のスマホに関する情報が出れば、接続完了。

#### 4-3A-2. IDE 側の設定

実行する方法は以下のいずれか。

- Android Studio にて。  
  Device Manager ウィンドウにて Physical タブを開き、`ctrl + f5`。
- VSCode にて。  
  Device ボタンにて、自分の Android 実機を選択。
  `lib/main.dart` を開いた状態で `f5`。

### 4-3B. Android エミュレーター上に起動

<img src="https://github.com/moyomogi/flutter_testing/raw/master/docs/imgs/suggestion-virtual-android.jpg" title="suggestion-virtual-android" width="160">

Android エミュレーターを使う意味は、以下の通りです。

- Android スマホを持っていない人でも、Anroid 上でアプリを動かせる。
- 自分の持っていない機種 (古い機種や、特殊なアスペクト比の機種) 上でも動かせる。

Android エミュレーターは、1 台につき 10 GB くらい使うので、  
C ドライブの容量がやばい人は入れないでください。

#### 4-3B-1. Android エミュレーター (Pixel 4 API 32) を導入

1. `Phone` > `Pixel 4` を押す。
2. `API 32` の右にある `Download` を押す。

#### 4-3B-2. Android エミュレーターにて起動

1. Android Studio を起動。
2. `Projects` > `More Actions ∨` > `Virtual Device Manager` を開く。
3. `Pixel 4 API 32` の `▷` を押す。  
   これでエミュレーターが起動完了。
4. 実行する方法は以下のいずれか。
   - Android Studio にて `ctrl + f5` を押す。
   - VSCode にて `lib/main.dart` を開いた状態で `f5`。

なお、こまめに Android Studio の `▽` から `Wipe Data` (溜まったキャッシュをクリア) する必要があるらしい。

## 不要だったもの

### (多分不要だけど残しとく) Java SDK を導入

1. フォルダを 2 個 (`D:\sys\Java`, `D:\sys\Java\jdk-18.0.1`) 作る。
2. [Java Downloads | Oracle](https://www.oracle.com/java/technologies/downloads/#jdk18-windows) から  
   `https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe` をダウンロード。
3. exe を実行し、ダウンロードフォルダは `D:\sys\Java\jdk-18.0.1` とする。
4. 「環境変数」を開いて、新規に変数 JAVA_HOME を値 `D:\sys\Java\jdk-18.0.1` として追加。
5. ライセンスに yes する。(Java SDK が必要)

```ps1
flutter doctor --android-licenses
```

### (不要かも？) .NET SDK を導入

[Download .NET SDK for Visual Studio Code](https://dotnet.microsoft.com/en-us/download/dotnet/sdk-for-vs-code) にて。

## 踏んだバグとその解決方法

- `$FLUTTER_ROOT/bin/cache/lockfile` が残っていることが原因なので、削除したい。  
  削除するには `dart.exe` を終了する必要があるので、`ctrl + shift + esc` で  
  タスクマネージャーを開いて `dart.exe` に対し「タスクの終了」をする。  
  その後、`$FLUTTER_ROOT/bin/cache/lockfile` を削除する。  
  Ref: [flutter コマンドを打った時に"Waiting for another flutter command to release the startup lock..."が出た時の対処法](https://qiita.com/konifar/items/29f2ed4bcc2a970014c1)

```ps1
# (参考) タスクの終了をコマンドでしたい場合
taskkill /F /IM dart.exe
```

## 参考文献

- [Flutter 環境構築 -Windows 編-](https://www.ccs1981.jp/blog/flutter%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89-windows%E7%B7%A8/)
- [Windows install | Flutter](https://docs.flutter.dev/get-started/install/windows)
- [Firebase CLI リファレンス](https://firebase.google.com/docs/cli?hl=ja#install-cli-windows)
- [【Flutter】Web アプリを 🚀 爆速 🚀 で Firebase Hosting にデプロイする](https://zenn.dev/pressedkonbu/articles/deploy-flutter-web-app-with-firebase-hosting)
- [Failed to launch emulator: Error: Emulator didn't connected within 60 seconds 【AndroidStudio/VScode】](https://ticktickboom.hatenablog.com/entry/2021/02/22/235914)
- [【Android Studio】Flutter で開発したアプリを実機でデバッグする](http://www.toshioblog.com/archives/27396852.html)
