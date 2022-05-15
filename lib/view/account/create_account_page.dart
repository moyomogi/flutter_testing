import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/utils/fire.dart';
import 'package:flutter_testing/utils/vars.dart';
import 'dart:html';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/utils/fire.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/subject.dart';
import 'dart:math' as math;

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  /*XFile? Ximage;
  File? image;
  ImagePicker picker = ImagePicker();

  Future<void> getImageFromGallery() async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      setState(() {
        Ximage = pickedFile;
        print(Ximage.path);
      });
    }
  }*/

  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  //TextEditingController gakuikiController = TextEditingController();
  TextEditingController gakuikiController = TextEditingController();
  TextEditingController kateiController = TextEditingController();

  TextEditingController kamoku1Controller = TextEditingController();
  TextEditingController kamoku2Controller = TextEditingController();
  TextEditingController kamoku3Controller = TextEditingController();

  var random = math.Random();
  var iconNum;

  void AssignIconNumber() {
    iconNum = random.nextInt(5);
  }
  bool isCheaked0 = false;
  bool isCheaked1 = false;
  bool isCheaked2 = false;
  bool isCheaked3 = false;
  bool isCheaked4 = false;
  List<Subject> subjectList = Vars.subjectList!;
  List<String> kamokuIdList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   Future(() async {
  //     print(Vars.subjectIds!);
  //     //await Firestore.getsubjectList(Vars.subjectIds!);
  //     //print(Vars.subjectList!);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            '新規登録',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: [
              /*SizedBox(height: 30),
            GestureDetector(
              /*onTap: (){
                getImageFromGallery();
              },*/
              child: CircleAvatar(
                //foregroundImage: Ximage == null ? null: FileImage(Ximage),
                radius: 40,
                child: Icon(Icons.add),
              ),
            ),*/
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
              Text("あなたの履修している科目を選択してください"),
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
              /*Container(
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
              ),*/
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  if (userIdController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('ユーザーIDを入力してください')),
                    );
                    return;
                  }
                  if (gakuikiController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('学部を入力してください')),
                    );
                    return;
                  }
                  if (kateiController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('学科を入力してください')),
                    );
                    return;
                  }
                  /*if (kamoku1Controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('科目名1を入力してください')),
                    );
                    return;
                  }
                  if (kamoku2Controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('科目名2を入力してください')),
                    );
                    return;
                  }
                  if (kamoku3Controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('科目名3を入力してください')),
                    );
                    return;
                  }*/
                  if (emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('メールアドレスを入力してください')),
                    );
                    return;
                  }
                  if (passController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('パスワードを入力してください')),
                    );
                    return;
                  }
                  AssignIconNumber();
                  print(iconNum);

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
                  var result = await Authentication.signUp(
                      email: emailController.text, pass: passController.text);
                  if (result is UserCredential) {
                    Account newAccount = Account(
                      internalId: result.user!.uid,
                      userId: userIdController.text,
                      name: nameController.text,

                      undergraduate: [
                        gakuikiController.text,
                        kateiController.text
                      ],
                      subjectIds: kamokuIdList, //ここsubjectListでidに変更したい
                      imagePath:
                          "assets/Icons/Icon_" + iconNum.toString() + ".png",
                    );
                    var _result = await Fire.setUser(newAccount);
                    if (_result == true) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('アカウントを作成'),
              )
            ],
          ),
        ));
  }
}
