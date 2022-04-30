# Flutter 環境構築 for WSL

<img src="https://i.imgur.com/rHZDb5q.png" title="shiroko" width="180">

Flutter を Windows に直置きしてもいいですが、  
VSCommunity, Android Studio を導入しなければならず、かなり容量を食います。  
従って、ここでは、WSL 上に Flutter 環境を構築しようと思います。  
WSL 上に Flutter 環境を構築すれば、VSCommunity, Android Studio が両方不要で、VSCode だけでよくなります。

## 1. Java SDK を追加

```sh
sudo apt update
sudo apt install -y default-jdk
echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
```

## 2. Android 環境

### 2-1. Android SDK を導入

1. フォルダを 4 個生成。

```sh
# ~/Android
# ~/Android/SDK
# ~/Android/SDK/cmdline-tools
# ~/Android/SDK/cmdline-tools/latest
# を生成する。
mkdir -p ~/Android/SDK/cmdline-tools/latest
```

2. [Android Studio 公式ダウンロードページ](https://developer.android.com/studio/index.html?authuser=1#downloads) の下の方にある `commandlinetools-linux-8092744_latest.zip` (8092744 はバージョンにより異なる) をダウンロード。
3. zip を展開する。cmdline-tools というフォルダが生成されるはず。
4. `~/Android/SDK/cmdline-tools/latest` (つまり `\\wsl$\Ubuntu-20.04\home\YOUR_NAME\Android\SDK\cmdline-tools\latest`) cmdline-tools の中身を貼り付け。(以下の画像のようになる。)

![](https://github.com/moyomogi/flutter_testing/raw/master/docs/cmdline-tools.jpg)

5. Android SDK のパスを通す。

```sh
# ~/.bashrc に追記
echo "export ANDROID_HOME=\$HOME/Android/SDK" >> ~/.bashrc
echo "export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin" >> ~/.bashrc

# ~/.bashrc の内容を再読み込み
source ~/.bashrc

# [=======================================] 100% Computing updates...
# のように表示されれば成功。
```

### 2-2. `adb` (Android Debug Bridge) を導入

```sh
# sdkmanager を有効化。
sdkmanager

# 「Accept? (y/N):」と聞かれるので、
# y (yes の意) と打って Enter。
sdkmanager --install "platform-tools"

echo "export PATH=\$PATH:\$ANDROID_HOME/platform-tools" >> ~/.bashrc
source ~/.bashrc
adb
```

### 2-3. Android (API レベル 32) をインストール

```sh
sdkmanager "platform-tools" "platforms;android-32" "build-tools;32.0.0"
sdkmanager "system-images;android-32;google_apis_playstore;x86_64"
sdkmanager --licenses
```

## 3. `dotnet-sdk-6.0` のインストール

```sh
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt update
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y dotnet-sdk-6.0
```

## 4. Flutter 環境

### 4-1. コマンド `flutter`, `dart` を追加

```sh
cd ~
git clone https://github.com/flutter/flutter.git -b stable

# パスを通す。
# コマンド flutter, dart を使えるようになる
echo "export PATH=\$PATH:/home/miria/flutter/bin" >> ~/.bashrc
source ~/.bashrc

# flutter, dart が使えるようになっているか確認するため、
# flutter, dart のインストール位置を表示するコマンドを実行。
which flutter dart

flutter --version
flutter config --enable-web

# 「[!] Android Studio (not installed)」以外が
# [✓] になっていれば成功です！
flutter doctor
```

### 4-2. テンプレートプロジェクトをダウンロード

1. VSCode を開き、`ctrl + shift + p` で表示される窓から  
   「Flutter: New Application Project」を選択してください。
2. プロジェクトの種類を選択するよう言われるので、`Application` を選択。
3. 親フォルダを選択するよういわれるので、`/home/YOUR_NAME/` (YOUR_NAME は読み替えてね。) と入力。
4. プロジェクト名を入力するよう言われるので `flutter_testing` と入力。  
   すると、`/home/YOUR_NAME/flutter_testing` 配下にテンプレートプロジェクトが生成されます。

## 5. テンプレートプロジェクトをサーブ

## 5-1. VSCode にてフォルダ `flutter_testing` を開く

で、さっき作ったフォルダ `flutter_testing` を選択。

### 5-2. localhost にサーブ

```sh
# lib/main.dart を元に localhost にサーブする。
# Chrome や Vivaldi といったウェブブラウザにて、
# localhost にアクセスしたら内容を見れる。
flutter run -d web-server
```

## 6. (補遺) 各種コマンドの説明

### 6-1. (今すぐには不要) `flutter` をアップグレード

今はインストールしたばかりで最新の状態なので不要ですが、  
将来、新バージョンにアップデートしたくなったときは  
以下のようにすればよいです。

```sh
# flutter pub get は
# ~/flutter/packages/flutter_tools/pubspec.yml
# を参照する必要があるため、カレントディレクトリを変更。
cd ~/flutter/packages/flutter_tools

# ~/flutter/packages/flutter_tools/pubspec.yml
# の変更内容に応じて、ライブラリを取得・更新。
flutter pub get
# flutter を更新
flutter upgrade
```

### 6-2. ビルド

```sh
# XXX には
# - apk (Android 用)
# - iso (iOS 用)
# - web (Web アプリ用)
# - macos (Mac OS 用)
# - linux (Linux 用)
# - windows (Windows 用)
# が入ります。
flutter build XXX
```

### 6-3. Flutter アプリとして実行可能なデバイス一覧

Android/iOS エミュレータの場合は、事前に立ち上げた状態でなければ表示されません。

```sh
flutter devices
```

## 参考文献

- [[Flutter] WSL2 環境で Flutter Web （その 1）](https://techfree.jp/devmemo/try-flutter-1)
- [WSL2 で Flutter 環境をできるだけクリーンに構築する(えみ)](https://qiita.com/suruseas/items/42d5d9c5beffa6ebdd78#3-flutter%E7%92%B0%E5%A2%83%E3%81%AE%E6%A7%8B%E7%AF%89)
- [Ubuntu 20.04 に dotnet-sdk-6.0 をインストール | Microsoft Docs](https://docs.microsoft.com/ja-jp/dotnet/core/install/linux-ubuntu#2004-)
- [Flutter コマンド一覧まとめ](https://qiita.com/kurun_pan/items/f9251b1827ce9dca9e14)
