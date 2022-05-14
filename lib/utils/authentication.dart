import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_testing/model/account.dart';
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
  static Account? myAccount;

  static Future<dynamic> signUp({required String email,required String pass}) async{
    try{
      final UserCredential _result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      debugPrint("auth signup完了//outh signではない");
      return _result;
    } on FirebaseAuthException catch(_){
      debugPrint("auth error");
      return false;
    }
  }

  static Future<dynamic> emailSignIn(
      {required String email, required String pass}) async {
    try {
      final UserCredential _result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      currentFirebaseUser = _result.user;
      debugPrint("currentFirebaseUser");
      debugPrint(currentFirebaseUser!.uid);
      debugPrint('auth signin');
      return _result;
    } on FirebaseAuthException catch(e){
      debugPrint("auth signin error");
      return false;
    }
  }
}
