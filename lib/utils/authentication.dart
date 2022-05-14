import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  // var result = await Authentication.signUp(email: ~~~, pass: ===)
  // で result == true なら登録する感じ
  static Future<dynamic> signUp(
      {required String email, required String pass}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: pass);
      // この時点で myAccount が決定する。
      debugPrint("auth signup 完了 // outh signin ではない");
      return true;
    } on FirebaseAuthException catch (_) {
      debugPrint("auth signup error");
      return false;
    }
  }

  static Future<dynamic> emailSignIn(
      {required String email, required String pass}) async {
    try {
      final UserCredential _result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      currentFirebaseUser = _result.user;
      debugPrint('auth signin');
      return true;
    } on FirebaseAuthException catch (_) {
      debugPrint("auth signin error");
      return false;
    }
  }
}
