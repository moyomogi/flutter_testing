// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBzVO74tmPwem7wofYTWMdemKY9qJOPuec',
    appId: '1:366881475838:web:23fe17f24bc53e899369af',
    messagingSenderId: '366881475838',
    projectId: 'fluttertesting-63ba1',
    authDomain: 'fluttertesting-63ba1.firebaseapp.com',
    storageBucket: 'fluttertesting-63ba1.appspot.com',
    measurementId: 'G-Y22245SCDH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCedOsJ-3zDFIbm_vWInEMfUX-xvsvf6Zc',
    appId: '1:366881475838:android:a5f7d8a79af5bc919369af',
    messagingSenderId: '366881475838',
    projectId: 'fluttertesting-63ba1',
    storageBucket: 'fluttertesting-63ba1.appspot.com',
  );
}
