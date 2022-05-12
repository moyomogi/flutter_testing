import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({ Key? key }) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String? gakuiki = 'aa';
  String? gakurui = 'bb';
  String? katei = 'cc';
  
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
            SizedBox(height: 30),
            CircleAvatar(
              radius: 40,
              child: Icon(Icons.add),
            ),
            TextField(),

            /*DropdownButton(//学域
              items: const [
                DropdownMenuItem(
                  child: Text('i'),
                  value: 'i',
                ),
                DropdownMenuItem(
                  child: Text('a'),
                  value: 'a',
                ),
              ],
              onChanged: (String? value) {
                setState(() {
                  gakuiki = value;
                });
              },
              value: gakuiki,
            ),*/
            /*DropdownButton(//学類
              items: const [
                DropdownMenuItem(
                  child: Text('電気電子系学類'),
                  value: '電気電子系学類',
                ),
                DropdownMenuItem(
                  child: Text('機械系学類'),
                  value: '機械系学類',
                ),
                DropdownMenuItem(
                  child: Text("物質科学系学類"),
                  value: "物質科学系学類",
                )
              ],
              onChanged: (String? value) {
                setState(() {
                  gakurui = value;
                });
              },
              value: gakurui,
            ),
            DropdownButton(//課程
              items: const [
                DropdownMenuItem(
                  child: Text('情報工学課程'),
                  value: '情報工学課程',
                ),
                DropdownMenuItem(
                  child: Text('電気電子システム課程'),
                  value: '電気電子システム課程',
                ),
                DropdownMenuItem(
                  child: Text("電子物理課程"),
                  value: "電子物理課程",
                )
              ],
              onChanged: (String? value) {
                setState(() {
                  katei = value;
                });
              },
              value: katei,
            ),*/
            

          ],
        ),
      )
    );
  }
}