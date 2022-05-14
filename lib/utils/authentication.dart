import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_testing/model/account.dart';

class Authentication{
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;
  static Account? myAccount;

  static Future<dynamic> signUp({required String email,required String pass}) async{
    try{
      final UserCredential _result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      print("auth signup完了//outh signではない");
      return _result;
    } on FirebaseAuthException catch(e){
      print("auth error");
      return false;
    }
  }

  static Future<dynamic> emailSignIn({required String email, required String pass}) async{
    try{
      final UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
      currentFirebaseUser = _result.user;
      print("currentFirebaseUser");
      print(currentFirebaseUser!.uid);
      print('auth signin');
      return _result;
    } on FirebaseAuthException catch(e){
      print("auth signin error");
      return false;
    }
  }
}