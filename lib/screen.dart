import 'package:flutter/material.dart';

import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/view/default_page/default_page.dart';
import 'package:flutter_testing/view/time_line_page/time_line_page.dart';
import 'package:flutter_testing/view/account/create_account_page.dart';
import 'package:flutter_testing/view/account/account_page.dart';
import 'package:flutter_testing/view/account/login_page.dart';
import 'package:flutter_testing/utils/authentication.dart';
import 'package:flutter_testing/model/account.dart';

class Screen extends StatefulWidget {
  final int Index;
  Screen(this.Index);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0; //0が最初の画面
  Account myAccount = Authentication.myAccount!;
  //List<Widget> pageList = [DefaultPage(), AccountPage()]; //ページ追加するなら


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedIndex == 0
            ? DefaultPage(myAccount)
            : AccountPage(myAccount),
      // body: [
      //   DefaultPage(widget.subjectList),
      //   AccountPage(widget.subjectList)
      // ][selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity_outlined), label: ''),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          // 押したタイミングでindexの値が変わる
          setState(() {
            print("Accountの値更新");
            myAccount = Authentication.myAccount!;
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
