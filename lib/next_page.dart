import 'package:flutter/material.dart';

//新しいページは新しいdartファイル作成により実現
class NextPage extends StatefulWidget {
  final String title;//変数の受け皿となる変数を定義する。
  NextPage(this.title);


  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(width: 50, child: Text('ID',textAlign: TextAlign.center,),),
                Container(width: 20, child: Text(':',textAlign: TextAlign.center,),),
                Text('毎回同じテキストを表示ID'),
              ]
            ),
            Row(
              children: <Widget>[
                Container(width: 50, child: Text('PW'),),
                Container(width: 20, child: Text(':'),),
                Text('毎回同じテキストを表示PW')
              ]
            ),
          ]
        )
      ),
    );
  }
}