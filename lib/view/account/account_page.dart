import 'package:flutter/material.dart';

import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/utils/vars.dart';
import 'package:flutter_testing/utils/fire.dart';
import 'package:flutter_testing/screen.dart';

class AccountPage extends StatefulWidget {
  final Account myAccount;
  const AccountPage(this.myAccount);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController gakuikiController = TextEditingController();
  TextEditingController kateiController = TextEditingController();

  bool isChecked0 = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  List<Subject> subjectList = Vars.subjectList!;
  List<Subject> allSubjectList = Vars.allSubjectList!;
  List<bool> isCheckedList = List.filled(100, false);
  List<String> newSubjectIdList = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.myAccount.name);
    userIdController = TextEditingController(text: widget.myAccount.userId);
    gakuikiController =
        TextEditingController(text: widget.myAccount.undergraduate[0]);
    kateiController =
        TextEditingController(text: widget.myAccount.undergraduate[1]);
  }

  @override
  Widget build(BuildContext context) {
    isCheckedList = List.filled(allSubjectList.length, false);
    for (int i = 0; i < subjectList.length; i++) {
      for (int j = 0; j < allSubjectList.length; j++) {
        if (subjectList[i].id == allSubjectList[j].id) {
          isCheckedList[j] = true;
          break;
        }
      }
    }
    debugPrint("{isCheckedList.length}: ${isCheckedList.length}");
    debugPrint("{allSubjectList.length}: ${allSubjectList.length}");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'アカウント編集ページ',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    color: Colors.blue.withOpacity(0.3),
                    height: 70,
                    width: 300,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32,
                              foregroundImage:
                                  NetworkImage(widget.myAccount.imagePath),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.myAccount.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text('@${widget.myAccount.userId}'),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: '名前',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: userIdController,
                    decoration: const InputDecoration(
                      hintText: 'ユーザーID',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: gakuikiController,
                    decoration: const InputDecoration(
                      hintText: '学域/学部',
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: kateiController,
                    decoration: const InputDecoration(
                      hintText: '課程/学科',
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: allSubjectList.length,
                  itemBuilder: (context, index) {
                    final subject = allSubjectList[index];
                    return SizedBox(
                        width: 300,
                        // https://docs.flutter.dev/testing/common-errors
                        // Row を使うなら、
                        // Row(children: Expanded(child: ...))
                        // とする
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  Checkbox(
                                      value: isCheckedList[index],
                                      onChanged: (value) {
                                        setState(() {
                                          isCheckedList[index] = value!;
                                        });
                                      }),
                                  Text(subject.name)
                                ],
                              )),
                            ]));
                  },
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   // Vars.allSubjectList.length の数だけ
                //   // CheckBox を生成したいねぇ。
                //   children: [
                //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //       Checkbox(
                //           value: isChecked0,
                //           onChanged: (value) {
                //             setState(() {
                //               isChecked0 = value!;
                //             });
                //           }),
                //       Text(subjectList[0].name),
                //     ]),
                //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //       Checkbox(
                //           value: isChecked1,
                //           onChanged: (value) {
                //             setState(() {
                //               isChecked1 = value!;
                //             });
                //           }),
                //       Text(subjectList[1].name),
                //     ]),
                //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //       Checkbox(
                //           value: isChecked2,
                //           onChanged: (value) {
                //             setState(() {
                //               isChecked2 = value!;
                //             });
                //           }),
                //       Text(subjectList[2].name),
                //     ]),
                //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //       Checkbox(
                //           value: isChecked3,
                //           onChanged: (value) {
                //             setState(() {
                //               isChecked3 = value!;
                //             });
                //           }),
                //       Text(subjectList[3].name),
                //     ]),
                //     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //       Checkbox(
                //           value: isChecked4,
                //           onChanged: (value) {
                //             setState(() {
                //               isChecked4 = value!;
                //             });
                //           }),
                //       Text(subjectList[4].name),
                //     ]),
                //   ],
                // ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isNotEmpty &&
                        userIdController.text.isNotEmpty &&
                        gakuikiController.text.isNotEmpty &&
                        kateiController.text.isNotEmpty) {
                      List<Subject> newSubjectList = [];
                      for (int i = 0; i < isCheckedList.length; i++) {
                        if (isCheckedList[i]) {
                          newSubjectList.add(allSubjectList[i]);
                        }
                      }
                      // if (isChecked0 == true) {
                      //   newSubjectIdList.add(subjectList[0].id);
                      // }
                      // if (isChecked1 == true) {
                      //   newSubjectIdList.add(subjectList[1].id);
                      // }
                      // if (isChecked2 == true) {
                      //   newSubjectIdList.add(subjectList[2].id);
                      // }
                      // if (isChecked3 == true) {
                      //   newSubjectIdList.add(subjectList[3].id);
                      // }
                      // if (isChecked4 == true) {
                      //   newSubjectIdList.add(subjectList[4].id);
                      // }
                      Account newAccount = Account(
                          internalId: widget.myAccount.internalId,
                          userId: userIdController.text,
                          name: nameController.text,
                          undergraduate: [
                            gakuikiController.text,
                            kateiController.text
                          ],
                          subjectIds: newSubjectIdList,
                          imagePath: widget.myAccount.imagePath);
                      // 下は、Vars.myAccount = newAccount; を含む
                      var result = await Fire.updateUser(newAccount);
                      if (result == false) {
                        debugPrint("(account_page) Error occured");
                        return;
                      }
                      debugPrint("DefaultPage に遷移");
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Screen(0)));
                    }
                  },
                  child: const Text('編集完了'),
                )
              ],
            ))));
  }
}
