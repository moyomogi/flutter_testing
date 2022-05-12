import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Authentication{
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  static Future<dynamic> signUp({required String email,required String pass}) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      print("auth signup完了//outh signではない");
      return true;//var result = await Authentication.signUp(email: ~~~,pass: ===)でtrueなら登録する感じ
    } on FirebaseAuthException catch(e){
      print("auto error");
      return false;
    }
  }

  static Future<dynamic> emailSignIn({required String email, required String pass}) async{
    try{
      final UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
      currentFirebaseUser = _result.user;
      print('auth signin');
      return true;
    } on FirebaseAuthException catch(e){
      print("auth signin error");
      return false;
    }
  }
}