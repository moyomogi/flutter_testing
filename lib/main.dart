import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/screen.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/utils/firestore.dart';
import 'package:flutter_testing/view/time_line_page/time_line_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Account newAccount = Account(
    name: 'やたぺんぎん',
    userId: 'yatapngn',
    undergraduate: ["工学域", "電気電子系学類", "情報工学課程"],
    subjectIds: ['0', '2'],
    imagePath:
        'https://1.bp.blogspot.com/-_CVATibRMZQ/XQjt4fzUmjI/AAAAAAABTNY/nprVPKTfsHcihF4py1KrLfIqioNc_c41gCLcBGAs/s800/animal_chara_smartphone_penguin.png',
  );
  Firestore.setUser(newAccount);
  var result = await Authentication.emailSignIn(
      email: "nisknishimura@gmail.com", pass: "Shouken0306");
  if (result == true) {
    initializeDateFormatting('fr_FR', null).then((_) => runApp(const MyApp()));
  }
  //Firestore.getUser();
  //initializeDateFormatting('fr_FR', null).then((_) => runApp(const MyApp()));
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
      title: "Fultter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen(),
    );
  }
}
