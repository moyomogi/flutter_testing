import 'package:flutter/material.dart';

// 新しいページは新しい dart ファイル作成により実現
class NextPage extends StatefulWidget {
  const NextPage(this.title);

  final String title;
  // ignore: use_key_in_widget_constructors

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
      body: Padding(
        padding: const EdgeInsets.all(30.0), //bodyに含まれるWidget全体に余白を追加
        child: Column(
          children: [
            Row(children: const <Widget>[
              SizedBox(width: 50),
              Expanded(
                child: Text('ID'),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(':'),
              ),
              Text('毎回同じテキストを表示する'),
            ]),
            const Padding(
              padding: EdgeInsets.all(5.0),
            ),
            Row(children: const <Widget>[
              SizedBox(width: 50),
              Expanded(
                child: Text('PW'),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(':'),
              ),
              Text('毎回同じパスワードを表示する'),
            ]),
          ],
        ),
      ),
    );
  }
}
