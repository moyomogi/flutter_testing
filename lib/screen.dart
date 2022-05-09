import 'package:flutter/material.dart';
import 'package:flutter_testing/view/time_line_page/time_line_page.dart';
import 'package:flutter_testing/view/account/account_page.dart';

class Screen extends StatefulWidget {
  const Screen({ Key? key }) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;//0が最初の画面
  List<Widget> pageList = [TimeLinePage(), AccountPage()];//ページ追加するなら


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity_outlined),
            label: ''
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index){//押したタイミングでindexの値が変わる
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}