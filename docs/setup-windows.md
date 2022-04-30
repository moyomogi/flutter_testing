# Flutter 環境構築 for Windows

<img src="https://i.imgur.com/xelxZnv.png" title="hoshino" width="180">

Web アプリ作るだけなら、WSL に入れれば容量食わないです。  
しかし、Android アプリを作るなら、Android Studio を入れた方がいいね。  
Android Studio の機能のうち使うのは以下の通りです。

- Android エミュレーターを扱う。
- Android SDK を導入。

IDE に関しては Android Studio で完結することも可能なんですが、  
よもぎは VSCode が好きなのでこっちで。

## 1. (共通) `flutter` のインストール

1. コマンドプロンプトにて。`git clone` する。

```cmd
git clone https://github.com/flutter/flutter.git -b stable
```

2. `win + s` で検索窓を出す。
   env と打って、「環境変数を編集」を押す。
3. 出てきたウィンドウある 2 窓のうち、上の方に、Path があるのでダブルクリック。
   出てきたウィンドウにて、`D:\sys\flutter\bin` を追記。

```cmd
where flutter dart
```

## 2. Web Application を作る

特に設定はないです。

## 3. Android Application を作る

### Android Studio をインストール

1. [Download Android Studio](https://developer.android.com/studio/?hl=ja&authuser=1#downloads) から `android-studio-2021.1.1.23-windows.exe` (2021.1.1.23 部分は 2022-04-30 時点のものです。) をダウンロード。

2. exe を起動し、`D:\sys\Android\Android Studio` (D:\sys\ の部分はご自由に。) にインストール。
   ラジオボタンが 3 個あるので、Decline -> Accept と変更する。

### Android SDK を導入

1. Android Studio を起動し、`Customize` > `All settings...`
2. `Appearance & Behavior` > `System Settings` > `Android SDK` を開く。
3. `SDK Tools` タブを開く。
4. 以下にチェックを入れて OK する。

- Android SDK Command-line Tools (latest)
- Android Emulator
- Android SDK Platform-Tools

5. パスを通すため、PowerShell にて以下を実行。

```ps1
flutter config --android-studio-dir "D:\sys\Android\Android Studio\bin"
```

### Android エミュレーター (API 32) を導入

1. `Phone` > `Pixel 3.a` を押す。
2. `API 32` の右にある `Download` を押す。

### Java SDK を導入

1. フォルダを 2 個 (`D:\sys\Java`, `D:\sys\Java\jdk-18.0.1`) 作る。
2. [Java Downloads | Oracle](https://www.oracle.com/java/technologies/downloads/#jdk18-windows) から `https://download.oracle.com/java/18/latest/jdk-18_windows-x64_bin.exe` をダウンロード。
3. exe を実行し、ダウンロードフォルダは `D:\sys\Java\jdk-18.0.1` とする。
4. 「環境変数」を開いて、新規に変数 JAVA_HOME を値 `D:\sys\Java\jdk-18.0.1` として追加。
5. ライセンスに yes する。(Java SDK が必要)

```sh
flutter doctor --android-licenses
```

### .NET SDK を導入

[Download .NET SDK for Visual Studio Code](https://dotnet.microsoft.com/en-us/download/dotnet/sdk-for-vs-code) にて。

### Virtual Device Manager

1. Android Studio を起動。
2. `Projects` > `More Actions ∨` > `Virtual Device Manager` を開く。
3. `Pixel 3a API 32` の `▷` を押す。

## 4. Windows Application を作る

(工事中)

## 参考文献

- [Flutter 環境構築 -Windows 編-](https://www.ccs1981.jp/blog/flutter%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89-windows%E7%B7%A8/)
- [Windows install | Flutter](https://docs.flutter.dev/get-started/install/windows)
