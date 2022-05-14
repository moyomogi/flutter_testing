import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_testing/main.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/utils/vars.dart';
import 'package:flutter_testing/utils/firestore.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/post.dart';

class TimeLinePage extends StatefulWidget {
  final Subject subject;
  // 以前のページである default_page.dart の情報を this.subject として引き継ぎ。
  const TimeLinePage(this.subject);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  
  Account myAccount = Authentication.myAccount!;
  TextEditingController controller = TextEditingController(); //送信するメッセージを格納


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.subject.name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.postsRef.orderBy('postTime',descending: true).snapshots(),//postsに追加されたもの感知
              builder: (context, postSnapshot) {
                if(postSnapshot.hasData){
                  print("postSnapshot.hasData");
                  List<String> postAccountsId = [];
                  postSnapshot.data!.docs.forEach((doc) {
                    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                    if(!postAccountsId.contains(data['userId'])){
                      postAccountsId.add(data['userId']);
                    }
                  });
                  return FutureBuilder<Map<String,Account>?>(
                    future: Firestore.getPostUserMap(postAccountsId),
                    builder: (context, userSnapshot) {
                      if(userSnapshot.hasData && userSnapshot.connectionState == ConnectionState.done){
                        return ListView.builder(
                        itemCount: postSnapshot.data!.docs.length,//postの数だけ探索
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data = postSnapshot.data!.docs[index].data() as Map<String,dynamic>;
                          if(data['roomId'] == widget.subject.id){
                            Post post = Post(
                            id: postSnapshot.data!.docs[index].id,
                            text : data['text'],
                            userId: data['userId'],
                            roomId: data['roomId'],
                            postTime: data['postTime']
                          );
                          print("post生成${post}");
                          Account postAccount = userSnapshot.data![post.userId]!;//postのuserIdからpostAccount特定
                          return Container(
                            decoration: BoxDecoration(
                                border: index == 0
                                    ? Border(
                                        top: BorderSide(color: Colors.grey, width: 0),
                                        bottom:
                                            BorderSide(color: Colors.grey, width: 0),
                                      )
                                    : Border(
                                        bottom:
                                            BorderSide(color: Colors.grey, width: 0))),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  foregroundImage: NetworkImage(postAccount.imagePath),
                                  backgroundColor: Colors.white,
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                                // myAccount.name
                                                child: Text(
                                                  postAccount.name,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                "@${postAccount.userId}",
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                // 日付
                                                // postList: やあ＾＾やあ＾＾
                                                child: Text(DateFormat('20yy/M/d H:m')
                                                    .format(post.postTime!
                                                        .toDate())),
                                              ), //year:month/day hour:minute
                                            ]),
                                            //Text(DateFormat('20yy/M/d H:m').format(postList[index].postTime!.toDate()))//year:month/day hour:minute
                                          ],
                                        ),
                                        Text(post.text),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                          }
                          else{
                            return Container();
                          }
                          
                        });
                      }
                      else{
                        return Container();
                      }
                      
                    }
                  );
                } 
                else{//snapshot.hasntData
                  print("postsに物がない");
                  return Container();
                }
                
              }
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller, // 送信するメッセージである controller を受け取る
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "ツイートを送信",
                      ),
                    ),
                  )),
                  IconButton(
                    icon: Icon(Icons.send),
                    // 送信ボタン
                    onPressed: () async {
                      // controller から、newPost を作成
                      debugPrint("ツイート");
                      // controller: 送信するメッセージ
                      if (controller.text.isNotEmpty) {
                        Post newPost = Post(
                          text: controller.text,
                          userId: myAccount.internalId,
                          roomId: widget.subject.id,
                        );
                        await Firestore.addPost(newPost);//idと投稿時間はここで追加

                        controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      /*floatingActionButton: FloatingActionButton(//ツイートボタン
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
        },
        child: Icon(Icons.chat_bubble_outline_sharp),
      ),*/
    );
  }
}
