# Flutter 環境構築 for Windows

<img src="https://i.imgur.com/xelxZnv.png" title="hoshino" width="180">

## 0. 緒言

- Web アプリ作るだけなら、WSL に入れれば容量食わないです。  
  しかし、Android アプリを作るなら、Android Studio を入れた方がいいね。  
  Android Studio の機能のうち使うのは以下の通りです。

  - Android エミュレーターを扱う。
  - Android SDK を導入。

- IDE に関しては Android Studio で完結することも可能なんですが、  
  よもぎは VSCode が好きなので VSCode で。
- Flutter で作れるものは以下の通りです。
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
3. 出てきたウィンドウある 2 窓のうち、上の方に、Path があるのでダブルクリック。
   出てきたウィンドウにて、`D:\sys\flutter\bin` を追記。

```cmd
where flutter dart
```

- TODO: `4-1.`, `4-2.` も共通要件かも？

## 2. Web Application を起動

<img src="https://github.com/moyomogi/flutter_testing/raw/master/docs/suggestion-web.jpg" title="suggestion-web" height="280">

1. VSCode の右下で Device を `Chrome (web-javascript)` に変更。
2. `lib/main.dart` 上で `F5` を押すと起動する。

## 3. (任意、重い) Windows desktop development のための追加要件

<img src="https://github.com/moyomogi/flutter_testing/raw/master/docs/suggestion-windows.jpg" title="suggestion-windows" height="280">

### 3-1. Visual Studio Community をインストール

[Visual Studio 2022 Community](https://visualstudio.microsoft.com/ja/downloads/) からインストール。  
ただし、インストール時に `Desktop development with C++` というワークロードが必要。

### 3-2. Windows Application を起動

1. VSCode の右下で Device を `Windows (windows-x64)` に変更。
2. `lib/main.dart` 上で `F5` を押すだけ。

## 4. (任意) Android Application を作る

### 4-1. Android Studio をインストール

1. [Download Android Studio](https://developer.android.com/studio/?hl=ja&authuser=1#downloads) から `android-studio-2021.1.1.23-windows.exe` (2021.1.1.23 部分は 2022-04-30 時点のものです。) をダウンロード。

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

5. パスを通すため、PowerShell にて以下を実行。

```ps1
# パスを通す。このパスに Java SDK があります。
flutter config --android-studio-dir "D:\sys\Android\Android Studio"
```

```ps1
# ライセンスに yes する。 (Java SDK が必要)
flutter doctor --android-licenses
```

### 4-3. Android エミュレーター (Pixel 4 API 32) を導入

1. `Phone` > `Pixel 4` を押す。
2. `API 32` の右にある `Download` を押す。

### 4-4. Android 実機上で起動

1. Android にて `USB デバッグ` を ON にする
   `設定` > `システム` > `詳細設定` > `開発者向けオプション` を開き、`USB デバッグ` を ON にしましょう。
2. install

```ps1
$ flutter devices
4 connected device:

S5 SH (mobile)    • 357780092668389 • android-arm64  • Android 11 (API 30)
Windows (desktop) • windows         • windows-x64    • Microsoft Windows [Version 10.0.19044.1645]
Chrome (web)      • chrome          • web-javascript • Google Chrome 100.0.4896.127
Edge (web)        • edge            • web-javascript • Microsoft Edge 101.0.1210.32

$ flutter install -d 357780092668389
```

### 4-5. (できてない) Android エミュレーター上に起動

1. Android Studio を起動。
2. `Projects` > `More Actions ∨` > `Virtual Device Manager` を開く。
3. `Pixel 4 API 32` の `▷` を押す。
   これでエミュレーターが起動完了。
4. VSCode にて `lib/main.dart` を開いた状態で `F5`

なお、こまめに `▽` から `Wipe Data` (溜まったキャッシュをクリア) する必要があるらしい。

## (不要)

### (多分不要だけど残しとく) Java SDK を導入

1. フォルダを 2 個 (`D:\sys\Java`, `D:\sys\Java\jdk-18.0.1`) 作る。
2. [Java Downloads | Oracle](https://www.oracle.com/java/technologies/downloads/#jdk18-windows) から `https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe` をダウンロード。
3. exe を実行し、ダウンロードフォルダは `D:\sys\Java\jdk-18.0.1` とする。
4. 「環境変数」を開いて、新規に変数 JAVA_HOME を値 `D:\sys\Java\jdk-18.0.1` として追加。
5. ライセンスに yes する。(Java SDK が必要)

```ps1
flutter doctor --android-licenses
```

### (不要かも？) .NET SDK を導入

[Download .NET SDK for Visual Studio Code](https://dotnet.microsoft.com/en-us/download/dotnet/sdk-for-vs-code) にて。

## 踏んだバグとその解決方法

- `$FLUTTER_ROOT/bin/cache/lockfile` が残っていることが原因なので、削除したい。削除するには `dart.exe` を終了する必要があるので、`ctrl + shift + esc` でタスクマネージャーを開いて `dart.exe` に対し「タスクの終了」をする。その後、`$FLUTTER_ROOT/bin/cache/lockfile` を削除する。
  Ref: [flutter コマンドを打った時に"Waiting for another flutter command to release the startup lock..."が出た時の対処法](https://qiita.com/konifar/items/29f2ed4bcc2a970014c1)

```ps1
# (参考) タスクの終了をコマンドでしたい場合
taskkill /F /IM dart.exe
```

## 参考文献

- [Flutter 環境構築 -Windows 編-](https://www.ccs1981.jp/blog/flutter%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89-windows%E7%B7%A8/)
- [Windows install | Flutter](https://docs.flutter.dev/get-started/install/windows)
- [Failed to launch emulator: Error: Emulator didn't connected within 60 seconds 【AndroidStudio/VScode】](https://ticktickboom.hatenablog.com/entry/2021/02/22/235914)
- [【Android Studio】Flutter で開発したアプリを実機でデバッグする](http://www.toshioblog.com/archives/27396852.html)
