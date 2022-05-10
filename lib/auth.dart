import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



class MyAuthPage extends StatefulWidget {

  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {

  //https://www.flutter-study.dev/firebase/authentication
  //入力されたメールアドレス
  String newUserEmail = "";
  //入力されたパスワード
  String newUserPassword = "";
  //登録・ログインに関する情報を表示
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ログインページ"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),
                onChanged: (String value){
                  setState(() {
                    newUserEmail = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード(6文字以上)"),
                //パスワード見えないように
                obscureText: true,
                onChanged: (String value){
                  setState(() {
                    newUserPassword = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed:() async{
                  try {
                    //メール/パスワードでユーザ登録
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result = 
                      await auth.createUserWithEmailAndPassword(
                        email: newUserEmail,
                        password: newUserPassword,
                      );
                    
                    //登録したユーザー情報
                    final User user = result.user!;
                    setState(() {
                      infoText = "登録OK: ${user.email}";
                    });
                  } catch(e){
                    //登録に失敗
                    setState(() {
                      infoText = "登録NG: ${e.toString()}";
                    });
                  }
                },
                child: Text("ユーザー登録"),
              ),
              const SizedBox(height: 8),
              Text(infoText)
            ],
          ),
        ),
      ),
    );
  }
}