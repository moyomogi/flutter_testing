import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/utils/firestore.dart';
import 'dart:html';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter_testing/model/account.dart';
import 'dart:math' as math;


class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({ Key? key }) : super(key: key);

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
  TextEditingController gakuruiController = TextEditingController();
  TextEditingController kateiController = TextEditingController();

  TextEditingController kamoku1Controller = TextEditingController();
  TextEditingController kamoku2Controller = TextEditingController();
  TextEditingController kamoku3Controller = TextEditingController();

  var random = math.Random();
  var iconNum;

  void AssignIconNumber(){
    iconNum = random.nextInt(5);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('新規登録',style: TextStyle(color:Colors.black),),
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
                controller: gakuruiController,
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
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async{
                if(nameController.text.isNotEmpty
                && userIdController.text.isNotEmpty
                && gakuruiController.text.isNotEmpty
                && kateiController.text.isNotEmpty
                && kamoku1Controller.text.isNotEmpty
                && kamoku2Controller.text.isNotEmpty
                && kamoku3Controller.text.isNotEmpty
                && emailController.text.isNotEmpty
                && passController.text.isNotEmpty
                //&& image != null
                ) {
                  AssignIconNumber();
                  print(iconNum);
                  var result = await Authentication.signUp(email: emailController.text, pass: passController.text);
                  if(result is UserCredential){
                    Account newAccount = Account(
                      internalId: result.user!.uid,
                      userId: userIdController.text,
                      name: nameController.text,
                      undergraduate: [gakuruiController.text , kateiController.text],
                      subjectIds: [kamoku1Controller.text,kamoku2Controller.text,kamoku3Controller.text],//ここsubjectListでidに変更したい
                      imagePath: "assets/Icons/Icon_" + iconNum.toString() + ".png",
                    );
                    var _result = await Firestore.setUser(newAccount);
                    if(_result == true){
                      Navigator.pop(context);
                    }
                  }
                }
              },
              child: Text('アカウントを作成'),
            )
          ],
        ),
      )
    );
  }
}