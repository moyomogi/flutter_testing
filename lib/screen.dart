import 'package:flutter/material.dart';

import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/utils/fire.dart';
import 'package:flutter_testing/utils/vars.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/view/default_page/default_page.dart';
import 'package:flutter_testing/view/time_line_page/time_line_page.dart';
import 'package:flutter_testing/view/account/create_account_page.dart';
import 'package:flutter_testing/view/account/account_page.dart';
import 'package:flutter_testing/view/account/login_page.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/model/account.dart';

class Screen extends StatefulWidget {
  final int _index;
  Screen(this._index);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0; //0が最初の画面
  Account myAccount = Vars.myAccount!;
  // List<Widget> pageList = [DefaultPage(), AccountPage()]; //ページ追加するなら

  // Flutterでウィジェットが作成されたタイミングで処理をする
  // https://qiita.com/sekitaka_1214/items/b087f9e9fc13424a64bb
  // 【Flutter入門】StatefulWidgetで使われるStateのライフサイクルを徹底解説！
  // https://tech-rise.net/what-is-lifecycle-of-state/
  // @override
  // void initState() {
  //   super.initState();
  //   debugPrint("initState start");
  //   initSubjectList();
  //   debugPrint("initState end");
  // }

  // dynamic initSubjectList() async {
  //   debugPrint(
  //       'myAccount.subjectIds: ${myAccount.subjectIds} -> assignSubjectList');
  //   await Fire.assignSubjectList(myAccount.subjectIds);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          selectedIndex == 0 ? DefaultPage(myAccount) : AccountPage(myAccount),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity_outlined), label: ''),
        ],
        currentIndex: selectedIndex,
        onTap: (index) async {
          debugPrint('onTap');

          // debugPrint("initSubjectList");
          // await initSubjectList();

          // 押したタイミングでindexの値が変わる
          setState(() {
            debugPrint("Accountの値更新");
            myAccount = Vars.myAccount!;

            selectedIndex = index;
          });
        },
      ),
    );
  }
}
