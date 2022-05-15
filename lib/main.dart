import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/utils/firestore.dart';
import 'package:flutter_testing/utils/vars.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'package:flutter_testing/model/post.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/view/account/login_page.dart';
import 'package:flutter_testing/view/time_line_page/time_line_page.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /*Account newAccount = Account(
  
    name: 'やたぺんぎん',
    userId: 'yatapngn',
    undergraduate: ["工学域", "電気電子系学類", "情報工学課程"],
    subjectIds: ['0', '2'],
    imagePath:
        'https://1.bp.blogspot.com/-_CVATibRMZQ/XQjt4fzUmjI/AAAAAAABTNY/nprVPKTfsHcihF4py1KrLfIqioNc_c41gCLcBGAs/s800/animal_chara_smartphone_penguin.png',
  );
  
  Firestore.setUser(newAccount);*/
  // var result = await Authentication.emailSignIn(email: "nisknishimura@gmail.com",pass: "Shouken0306");
  // if (result == true){
  // initializeDateFormatting('fr_FR', null).then((_) => runApp(const MyApp()));
  // }

  // Firestore.getUser();
  // initializeDateFormatting('fr_FR', null).then((_) => runApp(const MyApp()));

  // 【Flutter】現在日時を日本語で取得する
  // https://zenn.dev/kenara/articles/7f93790003da50
  // DateFormat.yMMMMEEEEd('ja').format(DateTime.now()).toString() が使えるようになる。
  Firestore.getsubjectIds();
  initializeDateFormatting('fr_FR', null).then((_) => runApp(const MyApp()));
}
//todo の追加
//todo Firebaseログイン

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    //nisk branch作ったよ
    return MaterialApp(
      debugShowCheckedModeBanner: false, //デバッグバナー消す
      title: "大阪公立大学 非公式SNS",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }


}

// class Singleton {
//   static final Singleton _singleton = Singleton._internal();

//   factory Singleton() {
//     return _singleton;
//   }

//   Singleton._internal();
// }

// 【グローバル変数置き場】
class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    Firestore.getsubjectList(Firestore.getsubjectIds() as List<String>);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;

        // _myAccount を生成
        _myAccount = Account(
          name: user.displayName!,
          userId: user.uid,
          imagePath:
              'https://1.bp.blogspot.com/-_CVATibRMZQ/XQjt4fzUmjI/AAAAAAABTNY/nprVPKTfsHcihF4py1KrLfIqioNc_c41gCLcBGAs/s800/animal_chara_smartphone_penguin.png',
        );
        debugPrint('$_myAccount');

        // firestore/posts -> postList を生成
        _postListSubscription = FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _postLists = [];
          for (final doc in snapshot.docs) {
            _postLists.add(
              Post(
                id: doc.data()['id'] as String,
                postTime: doc.data()['postTime'] as Timestamp,
                roomId: doc.data()['roomId'] as String,
                text: doc.data()['text'] as String,
                userId: doc.data()['userId'] as String,
              ),
            );
          }
        });
        // account.subjectList -> subjectList を生成
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        // Add from here
        _postLists = [];
        _postListSubscription?.cancel();
        // to here.
      }
      notifyListeners();  // 変更した変数の反映
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  Account? _myAccount;
  Account? get myAccount => _myAccount;

  String? _email;
  String? get email => _email;

  StreamSubscription<QuerySnapshot>? _postListSubscription;
  List<Post> _postLists = [];
  List<Post> get postList => _postLists;

  List<Subject> _subjectLists = [];
  List<Subject> get subjectList => _subjectLists;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  // moyomogi
  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // Add from here
  Future<DocumentReference> addPostToPostList(String userId, String subjectId, String text) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    // Post
    return FirebaseFirestore.instance.collection('posts').add(<String, dynamic>{
      'id': FirebaseAuth.instance.currentUser!.uid,
      'userId': userId,
      'subjectId': subjectId,
      'text': text,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
    });
  }
  // To here
}
