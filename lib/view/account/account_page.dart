import 'package:flutter/material.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/utils/authentication.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({ Key? key }) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  TextEditingController gakuikiController = TextEditingController();
  TextEditingController gakuruiController = TextEditingController();
  TextEditingController kateiController = TextEditingController();

  TextEditingController kamoku1Controller = TextEditingController();
  TextEditingController kamoku2Controller = TextEditingController();
  TextEditingController kamoku3Controller = TextEditingController();

  Account myAccount = Authentication.myAccount!;
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('アカウント編集ページ',style: TextStyle(color:Colors.black),),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Center(
              child: Container(
                color: Colors.blue.withOpacity(0.3),
                height: 70,
                width: 300,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 32,
                          foregroundImage: NetworkImage(myAccount.imagePath),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(myAccount.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            Text('@${myAccount.userId}'),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: '名前',
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: userIdController,
                decoration: InputDecoration(
                  hintText: 'ユーザーID',
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: gakuruiController,
                decoration: InputDecoration(
                  hintText: '学類',
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: kateiController,
                decoration: InputDecoration(
                  hintText: '課程',
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: kamoku1Controller,
                decoration: InputDecoration(
                  hintText: '科目名1',
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: kamoku2Controller,
                decoration: InputDecoration(
                  hintText: '科目名2',
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: kamoku3Controller,
                decoration: InputDecoration(
                  hintText: '科目名3',
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: (){
                if(nameController.text.isNotEmpty
                && userIdController.text.isNotEmpty
                && gakuruiController.text.isNotEmpty
                && gakuikiController.text.isNotEmpty
                && gakuruiController.text.isNotEmpty
                && kateiController.text.isNotEmpty
                && kamoku1Controller.text.isNotEmpty
                && kamoku2Controller.text.isNotEmpty
                && kamoku3Controller.text.isNotEmpty
                && emailController.text.isNotEmpty
                && passController.text.isNotEmpty){
                  Navigator.pop(context);
                }
              },
              child: Text('編集完了'),
            )
          ],
        ),
      )
    );
  }
}