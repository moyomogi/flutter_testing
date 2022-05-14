import 'package:flutter/material.dart';

import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/utils/vars.dart';
import 'package:flutter_testing/utils/fire.dart';
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

  //Account myAccount = Vars.myAccount!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: widget.myAccount.name);
    userIdController = TextEditingController(text: widget.myAccount.userId);
    gakuikiController =
        TextEditingController(text: widget.myAccount.undergraduate[0]);
    kateiController =
        TextEditingController(text: widget.myAccount.undergraduate[1]);

    for (var i = 0;
        i < widget.myAccount.subjectIds.length;
        i++) {} //ここの処理 idから名前に変換してどうすんだろ

    kamoku1Controller =
        TextEditingController(text: widget.myAccount.subjectIds[0]);
    kamoku2Controller =
        TextEditingController(text: widget.myAccount.subjectIds[1]);
    kamoku3Controller =
        TextEditingController(text: widget.myAccount.subjectIds[2]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'アカウント編集ページ',
            style: TextStyle(color: Colors.black),
          ),
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
                              foregroundImage:
                                  NetworkImage(widget.myAccount.imagePath),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.myAccount.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
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
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        userIdController.text.isNotEmpty &&
                        gakuikiController.text.isNotEmpty &&
                        kateiController.text.isNotEmpty &&
                        kamoku1Controller.text.isNotEmpty &&
                        kamoku2Controller.text.isNotEmpty &&
                        kamoku3Controller.text.isNotEmpty) {
                      Account updateAccount = Account(
                          internalId: widget.myAccount.internalId,
                          userId: userIdController.text,
                          name: nameController.text,
                          undergraduate: [
                            gakuikiController.text,
                            kateiController.text
                          ],
                          subjectIds: [
                            kamoku1Controller.text,
                            kamoku2Controller.text,
                            kamoku3Controller.text
                          ], //ここsubjectListでidに変更したい
                          imagePath: widget.myAccount.imagePath);
                      Vars.myAccount = updateAccount;
                      var result = await Fire.updateUser(updateAccount);
                      if (result == true) {
                        debugPrint("DefaultPageに遷移");
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Screen(0)));
                      }
                    }
                  },
                  child: Text('編集完了'),
                )
              ],
            )));
  }
}
