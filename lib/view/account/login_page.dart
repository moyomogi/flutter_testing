import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Text('ログインページ'),
              Container(
                width: 300,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'メールアドレス',
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    hintText: 'パスワード',
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children:[
                    TextSpan(text: '新規登録は'),
                    TextSpan(text: 'こちら',
                    style: TextStyle(color: Colors.blue),
                    recognizer:TapGestureRecognizer()..onTap = (){
                      print("アカウント作成");
                    } 
                    ),
                  ]
                )
              ),
              ElevatedButton(
                onPressed: (){

                }, 
                child: Text("emailでログイン")
              ),
            ],
          ),
        ),
      ),
    );
  }
}