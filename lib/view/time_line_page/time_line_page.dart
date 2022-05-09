import 'package:flutter/material.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/post.dart';
import 'package:flutter_testing/view/time_line_page/post_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';


class TimeLinePage extends StatefulWidget {
  const TimeLinePage({ Key? key }) : super(key: key);

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
    id: '1',
    name: 'やたぺんぎん',
    selfIntroduction: 'なにもできない',
    userId: 'yatapngn',
    imagePath: 'https://1.bp.blogspot.com/-_CVATibRMZQ/XQjt4fzUmjI/AAAAAAABTNY/nprVPKTfsHcihF4py1KrLfIqioNc_c41gCLcBGAs/s800/animal_chara_smartphone_penguin.png',
    createdTime: DateTime.now(),
    updatedTime: DateTime.now()
  );

  List<Post> postList = [
    Post(id: '1',content: 'やあ＾＾',postAccountId: '1',createTime: DateTime.now()),
    Post(id: '2',content: '1くんやあ＾＾',postAccountId: '1',createTime: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("タイムライン",style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index){
          return Container(
            decoration: BoxDecoration(
              border: index == 0 ? Border(
                top: BorderSide(color: Colors.grey,width: 0),
                bottom: BorderSide(color: Colors.grey, width: 0),
              ) : Border(bottom: BorderSide(color: Colors.grey, width: 0))
            ),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundImage: NetworkImage(myAccount.imagePath),

                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(myAccount.name,style: TextStyle(fontWeight: FontWeight.bold),),
                                Text("@${myAccount.userId}", style: TextStyle(color: Colors.grey),),
                              ]
                            ),
                            Text(DateFormat('yy/M/d').format(postList[index].createTime!))//mouth/day/year
                          ],
                        ),
                        Text(postList[index].content),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(//ツイートボタン
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
        },  
        child: Icon(Icons.chat_bubble_outline_sharp),
      ),
    );
  }
}