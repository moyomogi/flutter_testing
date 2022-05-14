import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:flutter_testing/main.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/utils/firestore.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/post.dart';

class TimeLinePage extends StatefulWidget {
  final Subject subject;
  // 以前のページである default_page.dart の情報を this.subject として引き継ぎ。
  const TimeLinePage(this.subject, {Key? key}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
    internalId: '1',
    name: 'やたぺんぎん',
    userId: 'yatapngn',
    undergraduate: ["工学域", "電気電子系学類", "情報工学課程"],
    subjectIds: ['0', '1'],
    imagePath:
        'https://1.bp.blogspot.com/-_CVATibRMZQ/XQjt4fzUmjI/AAAAAAABTNY/nprVPKTfsHcihF4py1KrLfIqioNc_c41gCLcBGAs/s800/animal_chara_smartphone_penguin.png',
  );

  // List<Post> postList = [
  //   Post(
  //       id: '1',
  //       userId: '1',
  //       roomId: '',
  //       text: 'やぁ＾＾',
  //       postTime: Timestamp.now()),
  //   Post(
  //       id: '1',
  //       userId: '1',
  //       roomId: '',
  //       text: 'やぁ＾＾',
  //       postTime: Timestamp.now()),
  //   Post(
  //       id: '1',
  //       userId: '1',
  //       roomId: '',
  //       text: 'やぁ＾＾',
  //       postTime: Timestamp.now()),
  //   Post(
  //       id: '1',
  //       userId: '1',
  //       roomId: '',
  //       text: 'やぁ＾＾',
  //       postTime: Timestamp.now()),
  //   Post(
  //       id: '1',
  //       userId: '1',
  //       roomId: '',
  //       text: 'やぁ＾＾',
  //       postTime: Timestamp.now()),
  //   Post(
  //       id: '1',
  //       userId: '1',
  //       roomId: '',
  //       text: 'やぁ＾＾',
  //       postTime: Timestamp.now()),
  //   Post(
  //       id: '1',
  //       userId: '1',
  //       roomId: '',
  //       text: 'やぁ＾＾',
  //       postTime: Timestamp.now()),
  //   Post(
  //       id: '1',
  //       userId: '1',
  //       roomId: '',
  //       text: 'やぁ＾＾',
  //       postTime: Timestamp.now()),
  //   Post(
  //       id: '1',
  //       userId: '1',
  //       roomId: '',
  //       text: 'やぁ＾＾',
  //       postTime: Timestamp.now()),
  // ];

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
            child: Consumer<ApplicationState>(
              builder: (context, appState, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (appState.loginState ==
                        ApplicationLoginState.loggedIn) ...[
                      PostList(
                        addPost: (post) => appState.addPostToPostList(post),
                        postList: appState.postList,
                      ),
                    ]
                    // Container(
                    //   decoration: BoxDecoration(
                    //       border: Border(
                    //               bottom:
                    //                   BorderSide(color: Colors.grey, width: 0))),
                    //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    //   child: Row(
                    //     children: [
                    //       CircleAvatar(
                    //         radius: 30,
                    //         foregroundImage: NetworkImage(myAccount.imagePath),
                    //         backgroundColor: Colors.white,
                    //       ),
                    //       Expanded(
                    //         child: Container(
                    //           child: Column(
                    //             children: [
                    //               Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Row(children: [
                    //                     Padding(
                    //                       padding: const EdgeInsets.symmetric(
                    //                           horizontal: 2.0),
                    //                       // myAccount.name
                    //                       child: Text(
                    //                         myAccount.name,
                    //                         style: TextStyle(
                    //                             fontWeight: FontWeight.bold),
                    //                       ),
                    //                     ),
                    //                     Text(
                    //                       "@${myAccount.userId}",
                    //                       style: TextStyle(color: Colors.grey),
                    //                     ),
                    //                     Padding(
                    //                       padding: const EdgeInsets.symmetric(
                    //                           horizontal: 8.0),
                    //                       // 日付
                    //                       // postList: やあ＾＾やあ＾＾
                    //                       child: Text(DateFormat('20yy/M/d H:m')
                    //                           .format(postList[index]
                    //                               .postTime!
                    //                               .toDate())),
                    //                     ), //year:month/day hour:minute
                    //                   ]),
                    //                   //Text(DateFormat('20yy/M/d H:m').format(postList[index].postTime!.toDate()))//year:month/day hour:minute
                    //                 ],
                    //               ),
                    //               Text(postList[index].text),
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ]),
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
                          id: myAccount.internalId,
                          text: controller.text,
                          userId: myAccount.userId,
                          roomId: widget.subject.id,
                        );
                        await Firestore.addPost(newPost);

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
