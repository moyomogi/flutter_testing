import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_testing/main.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/utils/vars.dart';
import 'package:flutter_testing/view/account/create_account_page.dart';
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
    List<Subject> subjectList = Vars.subjectList!;
    debugPrint('subjectList: $subjectList');
    // Account myAccount = widget.myAccount;
    Account myAccount = Vars.myAccount!;
    // List<Subject> subjectList = [
    //   Subject(
    //       id: '15HiJNcV91Mi5qV0zmvF',
    //       name: 'アルゴリズムとデータ構造',
    //       professors: ['宇野'],
    //       dayOfTheWeek: ['Mon3'],
    //       grade: 2),
    //   Subject(
    //       id: '5n0A7c3Ek2lLc7gMSguu',
    //       name: '人工知能',
    //       professors: ['黄瀬', '内海'],
    //       dayOfTheWeek: ['Wed3'],
    //       grade: 3),
    //   Subject(
    //       id: 'KfwqLfSu84NT8g7fOmMK',
    //       name: '情報工学実験',
    //       professors: ['生方', '内海'],
    //       dayOfTheWeek: ['Wed3'],
    //       grade: 3),
    //   Subject(
    //       id: 'MpstdlraBgynY6HcBfSG',
    //       name: '情報工学演習',
    //       professors: ['生方', '本多'],
    //       dayOfTheWeek: ['Thu3'],
    //       grade: 3),
    //   Subject(
    //       id: 'Q7iKMR6YaDPlG5B0MWbL',
    //       name: 'データ解析',
    //       professors: ['林'],
    //       dayOfTheWeek: ['Fri3'],
    //       grade: 3)
    // ];

    // https://stackoverflow.com/questions/67078111/flutter-app-hide-appbar-action-according-to-applicationstate-value
    // final appState = Provider.of<ApplicationState>(context);

    // List<Subject> subjetList;
    // accountのsubjects_idに合致したsubjectListのindexを以下のfor文で格納O(n^2)
    // 長さ myAccount.subjectIds.length の List
    List<int> appropriateIndices = [];

    for (int i = 0; i < myAccount.subjectIds.length; i++) {
      for (int j = 0; j < subjectList.length; j++) {
        if (subjectList[j].id == myAccount.subjectIds[i]) {
          appropriateIndices.add(j);
          break;
        }
      }
      if (appropriateIndices[i] == -1) {
        debugPrint("Inappropriate です: ${myAccount.subjectIds[i]}");
      }
    }
    appropriateIndices.sort((a, b) => a.compareTo(b));
    debugPrint('appropriateIndices: $appropriateIndices');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ルーム一覧',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
      ),
      body: ListView.builder(
        // itemCount: widget.subjectList.length,
        itemCount: appropriateIndices.length,
        itemBuilder: (context, index) {
          return InkWell(
            // s
            onTap: () {
              debugPrint('tap');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      // time_line_page.dart に遷移。
                      builder: (context) => TimeLinePage(
                          subjectList[appropriateIndices[index]])));
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
                              subjectList[appropriateIndices[index]]
                                  .dayOfTheWeek[0]
                                  .substring(0, 3) +
                              '.png'), //dayOfTheWeekの最初の3文字取って曜日(一週間の中で複数ある場合は早い方)
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Text(subjectList[appropriateIndices[index]].name),
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
