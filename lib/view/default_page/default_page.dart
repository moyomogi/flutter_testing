import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/view/time_line_page/time_line_page.dart';

class DefaultPage extends StatefulWidget {
  final Account myAccount;
  const DefaultPage(this.myAccount);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {

  @override
  Widget build(BuildContext context) {
    

    List<Subject> subjetList = [
      Subject(
          id: '1',
          name: 'アルゴリズムとデータ構造',
          professers: ['宇野'],
          dayOfTheWeek: ['Mon3'],
          grade: 2),
      Subject(
          id: '2',
          name: '人工知能',
          professers: ['黄瀬', '内海'],
          dayOfTheWeek: ['Wed3'],
          grade: 3),
      Subject(
          id: '3',
          name: '情報工学実験',
          professers: ['生方', '内海'],
          dayOfTheWeek: ['Wed3'],
          grade: 3),
      Subject(
          id: '4',
          name: '情報工学演習',
          professers: ['生方', '本多'],
          dayOfTheWeek: ['Thu3'],
          grade: 3),
      Subject(
          id: '5',
          name: 'データ解析',
          professers: ['林'],
          dayOfTheWeek: ['Fri3'],
          grade: 3)
    ];

    List<int> appropriateIndices =
        []; //accountのsubjects_idに合致したsubjectListのindexを以下のfor文で格納O(n^2)

    for (int i = 0; i < widget.myAccount.subjectIds.length; i++) {
      for (int j = 0; j < subjetList.length; j++) {
        if (subjetList[j].id == widget.myAccount.subjectIds[i]) {
          appropriateIndices.add(j);
        } else {
          debugPrint("Inappropriate");
        }
      }
    }
    appropriateIndices.sort((a, b) => a.compareTo(b));
    print(appropriateIndices);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "ルーム一覧",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
      ),
      body: ListView.builder(
        itemCount: appropriateIndices.length,
        itemBuilder: (context, index) {
          return InkWell(
            // s
            onTap: () {
              debugPrint("tap");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      // time_line_page.dart に遷移。
                      builder: (context) =>
                          TimeLinePage(subjetList[appropriateIndices[index]],widget.myAccount)));
            },
            child: Column(
              children: [
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('assets/' +
                              subjetList[appropriateIndices[index]]
                                  .dayOfTheWeek[0]
                                  .substring(0, 3) +
                              '.png'), //dayOfTheWeekの最初の3文字取って曜日(一週間の中で複数ある場合は早い方)
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Text(subjetList[appropriateIndices[index]].name),
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
