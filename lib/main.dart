import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_testing/auth.dart';
import 'package:flutter_testing/screen.dart';
import 'package:flutter_testing/view/time_line_page/time_line_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() async{
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  initializeDateFormatting('fr_FR', null).then((_) => runApp(const MyApp()));
}
//todo の追加
//todo Firebaseログイン

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {//nisk branch作ったよ
    return MaterialApp(
      debugShowCheckedModeBanner: false,//デバッグバナー消す
      title: "Fultter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Screen(),
    );
  }
}

