import 'package:flutter/material.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/post.dart';
import 'package:flutter_testing/view/time_line_page/post_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';


class TimeLinePage extends StatefulWidget {

  final String subjectName;
  TimeLinePage(this.subjectName);

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  Account myAccount = Account(
    internalId: '1',
    name: 'やたぺんぎん',
    userId: 'yatapngn',
    undergraduate: '工学域電気電子系学類情報工学課程',
    subjectIds: '1',
    imagePath: 'https://1.bp.blogspot.com/-_CVATibRMZQ/XQjt4fzUmjI/AAAAAAABTNY/nprVPKTfsHcihF4py1KrLfIqioNc_c41gCLcBGAs/s800/animal_chara_smartphone_penguin.png',
  );

  List<Post> postList = [
    Post(id: '1',userId: '1',roomId:'',text: 'やぁ＾＾',postTime:DateTime.now()),
    Post(id: '1',userId: '1',roomId:'',text: 'やぁ＾＾',postTime:DateTime.now()),
    Post(id: '1',userId: '1',roomId:'',text: 'やぁ＾＾',postTime:DateTime.now()),
    Post(id: '1',userId: '1',roomId:'',text: 'やぁ＾＾',postTime:DateTime.now()),
    Post(id: '1',userId: '1',roomId:'',text: 'やぁ＾＾',postTime:DateTime.now()),
    Post(id: '1',userId: '1',roomId:'',text: 'やぁ＾＾',postTime:DateTime.now()),
    Post(id: '1',userId: '1',roomId:'',text: 'やぁ＾＾',postTime:DateTime.now()),
    Post(id: '1',userId: '1',roomId:'',text: 'やぁ＾＾',postTime:DateTime.now()),
    Post(id: '1',userId: '1',roomId:'',text: 'やぁ＾＾',postTime:DateTime.now()),
  ];

  TextEditingController controller = TextEditingController();//送信するメッセージを格納
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.subjectName,style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:60.0),
            child: ListView.builder(
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
                        backgroundColor: Colors.white,
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
                                  Text(DateFormat('20yy/M/d H:m').format(postList[index].postTime!))//year:month/day hour:minute
                                ],
                              ),
                              Text(postList[index].text),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,color: Colors.white,
              child: Row(
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                        controller: controller,//送信するメッセージ
                        decoration: InputDecoration(
                        border: OutlineInputBorder()
                      ),
                    ),
                  )),
                  IconButton(icon: Icon(Icons.send),
                    onPressed: (){
                      print("ツイート");
                      if(controller.text.isNotEmpty){
                        print(controller.text);
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