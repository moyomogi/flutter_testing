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

  bool isCheaked0 = false;
  bool isCheaked1 = false;
  bool isCheaked2 = false;
  bool isCheaked3 = false;
  bool isCheaked4 = false;
  List<Subject> subjectList = Vars.subjectList;
  List<String> kamokuIdList = [];
  //Account myAccount = Vars.myAccount!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<Subject> subjectList = Vars.subjectList;
    nameController = TextEditingController(text: widget.myAccount.name);
    userIdController = TextEditingController(text: widget.myAccount.userId);
    gakuikiController =
        TextEditingController(text: widget.myAccount.undergraduate[0]);
    kateiController =
        TextEditingController(text: widget.myAccount.undergraduate[1]);
    List<bool> flag = [false,false,false,false,false];

    /*for (var i = 0;
        i < subjectList.length;
        i++) {
          for(var j=0;i<widget.myAccount.subjectIds.length;j++){
            if(subjectList[i].id == widget.myAccount.subjectIds[j]){
              flag[i] == true;
            }
          }
        } //ここの処理 idから名前に変換してどうすんだろ

    if(flag[0] == true) isCheaked0 = true;
    if(flag[1] == true) isCheaked1 = true;
    if(flag[2] == true) isCheaked2 = true;
    if(flag[3] == true) isCheaked3 = true;
    if(flag[4] == true) isCheaked4 = true;*/
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isCheaked0, 
                          onChanged: (value){
                            setState(() {
                              isCheaked0 = value!;
                            });
                          }
                        ),
                        Text(subjectList[0].name),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isCheaked1, 
                          onChanged: (value){
                            setState(() {
                              isCheaked1 = value!;
                            });
                          }
                        ),
                        Text(subjectList[1].name),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isCheaked2, 
                          onChanged: (value){
                            setState(() {
                              isCheaked2 = value!;
                            });
                          }
                        ),
                        Text(subjectList[2].name),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isCheaked3, 
                          onChanged: (value){
                            setState(() {
                              isCheaked3 = value!;
                            });
                          }
                        ),
                        Text(subjectList[3].name),
                      ]
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isCheaked4, 
                          onChanged: (value){
                            setState(() {
                              isCheaked4 = value!;
                            });
                          }
                        ),
                        Text(subjectList[4].name),
                      ]
                    ),
                  ],
                ),
              ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        userIdController.text.isNotEmpty &&
                        gakuikiController.text.isNotEmpty &&
                        kateiController.text.isNotEmpty
                        ) {

                      if(isCheaked0 == true){
                        kamokuIdList.add(subjectList[0].id);
                      }
                      if(isCheaked1 == true){
                        kamokuIdList.add(subjectList[1].id);
                      }
                      if(isCheaked2 == true){
                        kamokuIdList.add(subjectList[2].id);
                      }
                      if(isCheaked3 == true){
                        kamokuIdList.add(subjectList[3].id);
                      }
                      if(isCheaked4 == true){
                        kamokuIdList.add(subjectList[4].id);
                      }
                      Account updateAccount = Account(
                          internalId: widget.myAccount.internalId,
                          userId: userIdController.text,
                          name: nameController.text,
                          undergraduate: [
                            gakuikiController.text,
                            kateiController.text
                          ],
                          subjectIds: kamokuIdList, //ここsubjectListでidに変更したい
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
