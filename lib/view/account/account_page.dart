import 'package:flutter/material.dart';

import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/utils/firestore.dart';
import 'package:flutter_testing/screen.dart';
import 'package:flutter_testing/view/default_page/default_page.dart';

class AccountPage extends StatefulWidget {

  final Account myAccount;
  AccountPage(this.myAccount);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();

  TextEditingController gakuikiController = TextEditingController();
  //TextEditingController gakuikiController = TextEditingController();
  TextEditingController kateiController = TextEditingController();

  TextEditingController kamoku1Controller = TextEditingController();
  TextEditingController kamoku2Controller = TextEditingController();
  TextEditingController kamoku3Controller = TextEditingController();

  //Account myAccount = Authentication.myAccount!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.myAccount.name);
    userIdController = TextEditingController(text: widget.myAccount.userId);
    gakuikiController = TextEditingController(text: widget.myAccount.undergraduate[0]);
    kateiController = TextEditingController(text: widget.myAccount.undergraduate[1]);

    for(var i=0;i< widget.myAccount.subjectIds.length;i++){

    }//ここの処理 idから名前に変換してどうすんだろ

    kamoku1Controller = TextEditingController(text: widget.myAccount.subjectIds[0]);
    kamoku2Controller = TextEditingController(text: widget.myAccount.subjectIds[1]);
    kamoku3Controller = TextEditingController(text: widget.myAccount.subjectIds[2]);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
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
                          foregroundImage: NetworkImage(widget.myAccount.imagePath),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(widget.myAccount.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            Text('@${widget.myAccount.userId}'),
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
                controller: gakuikiController,
                decoration: InputDecoration(
                  hintText: '学域/学部',
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: kateiController,
                decoration: InputDecoration(
                  hintText: '課程/学科',
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
              onPressed: () async{
                if(nameController.text.isNotEmpty
                && userIdController.text.isNotEmpty
                && gakuikiController.text.isNotEmpty
                && kateiController.text.isNotEmpty
                && kamoku1Controller.text.isNotEmpty
                && kamoku2Controller.text.isNotEmpty
                && kamoku3Controller.text.isNotEmpty
                ) {
                    Account updateAccount = Account(
                      internalId: widget.myAccount.internalId,
                      userId: userIdController.text,
                      name: nameController.text,
                      undergraduate: [gakuikiController.text , kateiController.text],
                      subjectIds: [kamoku1Controller.text,kamoku2Controller.text,kamoku3Controller.text],//ここsubjectListでidに変更したい
                      imagePath: widget.myAccount.imagePath
                    );
                    Authentication.myAccount = updateAccount;
                    var result = await Firestore.updateUser(updateAccount);
                    if(result == true){
                      print("DefaultPageに遷移");
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Screen(0)));
                    }
                  }
              },
              child: Text('編集完了'),
            )
          ],
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
                              Text(
                                myAccount.name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
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
                  controller: gakuikiController,
                  decoration: InputDecoration(
                    hintText: '学類/学部',
                  ),
                ),
              ),
              Container(
                width: 300,
                child: TextField(
                  controller: kateiController,
                  decoration: InputDecoration(
                    hintText: '課程/科',
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
                onPressed: () {
                  if (userIdController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('ユーザーIDを入力してください')),
                    );
                    return;
                  }
                  if (gakuikiController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('学部を入力してください')),
                    );
                    return;
                  }
                  if (kateiController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('学科を入力してください')),
                    );
                    return;
                  }
                  if (kamoku1Controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('科目名1を入力してください')),
                    );
                    return;
                  }
                  if (kamoku2Controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('科目名2を入力してください')),
                    );
                    return;
                  }
                  if (kamoku3Controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('科目名3を入力してください')),
                    );
                    return;
                  }
                  if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('メールアドレスを入力してください')),
                    );
                    return;
                  }
                  if (passController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('パスワードを入力してください')),
                    );
                    return;
                  }
                  Navigator.pop(context);
                },
                child: Text('編集完了'),
              )
            ],
          ),
        ));
  }
}
