import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/view/time_line_page/time_line_page.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({ Key? key }) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {



  @override
  Widget build(BuildContext context) {

    Account myAccount = Account(
      internalId: '1',
      name: 'やたぺんぎん',
      userId: 'yatapngn',
      undergraduate: ["工学域","電気電子系学類","情報工学課程"],
      subjectIds: ["1","2"],
      imagePath: 'https://1.bp.blogspot.com/-_CVATibRMZQ/XQjt4fzUmjI/AAAAAAABTNY/nprVPKTfsHcihF4py1KrLfIqioNc_c41gCLcBGAs/s800/animal_chara_smartphone_penguin.png',
    );

    List<Subject> subjetList = [
      Subject(
        id: '1',
        name: 'アルゴリズムとデータ構造',
        professers: ['宇野'],
        dayOfTheWeek: ['Mon3'],
        grade: 2
      ),
      Subject(
        id: '2',
        name: '人工知能',
        professers: ['黄瀬','内海'],
        dayOfTheWeek: ['Wed3'],
        grade: 3
      ),
      Subject(
        id: '3',
        name: '情報工学実験',
        professers: ['生方','内海'],
        dayOfTheWeek: ['Wed3'],
        grade: 3
      ),
      Subject(
        id: '4',
        name: '情報工学演習',
        professers: ['生方','本多'],
        dayOfTheWeek: ['Thu3'],
        grade: 3
      ),
      Subject(
        id: '5',
        name: 'データ解析',
        professers: ['林'],
        dayOfTheWeek: ['Fri3'],
        grade: 3
      )
    ];

    List<int> appopriateIndexs = [];//accountのsubjects_idに合致したsubjectListのindexを以下のfor文で格納O(n^2)

    for(int i=0;i<myAccount.subjectIds.length;i++){
      for(var j=0;j<subjetList.length;j++){
        subjetList[j].id == myAccount.subjectIds[i]
          ? appopriateIndexs.add(j)
          : print("Inapporiate");
      }
    }
    appopriateIndexs.sort((a, b) => a.compareTo(b));
    print(appopriateIndexs);
    


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ルーム一覧",style: TextStyle(color: Colors.black),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: appopriateIndexs.length,
        itemBuilder: (context,index){          
          return InkWell(
            onTap: (){
              print("tap");
              Navigator.push(context, MaterialPageRoute(builder: (context) => TimeLinePage(subjetList[appopriateIndexs[index]])));
            },
            child: Column(
              children: [
                Container(
                  height: 70,
                  child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CircleAvatar(backgroundImage: NetworkImage('assets/'+ subjetList[appopriateIndexs[index]].dayOfTheWeek[0].substring(0,3) + '.png'),//dayOfTheWeekの最初の3文字取って曜日(一週間の中で複数ある場合は早い方)
                          backgroundColor: Colors.white,),
                        ),
                        Text(subjetList[appopriateIndexs[index]].name),
                      ],
                  ),
                  
                ),
                Divider(),
              ],
            ),
          );
          
        },
      ),
    );
  }
}