import 'package:flutter/material.dart';

// 新しいページは新しい dart ファイル作成により実現
class NextPage extends StatefulWidget {
  // key を特定すべき
  const NextPage({Key? key}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
