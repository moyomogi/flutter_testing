import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({ Key? key }) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: Text("新規投稿",style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),//戻るアイコン
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: contentController,//contentControllerに文字が入る
            ),
            SizedBox(height: 40,),//空間開けたいとき便利
            ElevatedButton(
              onPressed: (){

              }, 
              child: Text("投稿"),
            ),

          ]),
      ),
    );
  }
}