import 'package:flutter/material.dart';
import 'package:flutter_testing/next_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() {
  runApp(const MyApp());
}
//todo の追加
//todo ホーム画面のタイトル変更
//todo リスト表示
//todo リスト間に区切り線表示
//todo リスト表示を動的に
//todo フロートアクションボタンをタップしたときに、リストにひとつ追加
//todo 新しい画面を作成し、リストをタップしたときに遷移
//todo 新しい画面のレイアウトを作成
//todo 新しい画面にリストからデータを引き継ぐ

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {//nisk branch作ったよ
    return MaterialApp(
      title: "Fultter",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'パスワード管理'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  List<String> titleList = ['Amazon', '楽天', 'Yahoo!'];

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     // _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("パスワード管理"),
      ),
      body: ListView.builder(
        itemCount: titleList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: <Widget>[
            ListTile(
                // leading: const Icon(Icons.security),
                leading: const Icon(Icons.vpn_key),
                title: Text(titleList[index]),
                onTap: () {
                  // タップした時の処理
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NextPage(titleList[index])));
                }),
            const Divider(),
          ]);
        },
      ),
      // body: ListView(
      //   //【ListView】複数のウィジェットを表示できるウィジェット。画面からはみ出たらスクロールで表示できる。
      //   children: <Widget>[
      //     ListTile(
      //       // アイコンです。
      //       //【ListTile】リストの１項目を表示するためのウィジェット
      //       leading: const Icon(Icons.security),
      //       // 名称です。
      //       //（leading）左端に何を表示するかを決めるプロパティ
      //       title: Text(titleList[0]), //（title）項目のタイトルを決めるプロパティ
      //     ),
      //     // 区切り線です。
      //     const Divider(),
      //     ListTile(
      //       leading: const Icon(Icons.security),
      //       title: Text(titleList[1]),
      //     ),
      //     const Divider(),
      //     ListTile(
      //       leading: const Icon(Icons.security),
      //       title: Text(titleList[2]),
      //     ),
      //     const Divider(),
      //   ],
      // ),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Invoke "debug painting" (press "p" in the console, choose the
      //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //     // to see the wireframe for each widget.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleList.add('Google');
          // print(titleList);
          debugPrint('$titleList');
          setState(() {
            // 画面の再描画
            // List に追加されても、
            // 画面の再描画されてないので。
          });
        },
        // onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

//todo ホーム画面のタイトル変更
//todo　リスト表示
//todo　
