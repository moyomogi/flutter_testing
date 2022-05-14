import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/post.dart';

class Paragraph extends StatelessWidget {
  Paragraph(this.post, this.myAccount);
  final Post post;
  final Account myAccount;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0))),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(children: [
            CircleAvatar(
              radius: 30,
              foregroundImage: NetworkImage(myAccount.imagePath),
              backgroundColor: Colors.white,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            // myAccount.name
                            child: Text(
                              myAccount.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "@${myAccount.userId}",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            // 日付
                            // postList: やあ＾＾やあ＾＾
                            child: Text(DateFormat('20yy/M/d H:m')
                                .format(post.postTime!.toDate())),
                          ), //year:month/day hour:minute
                        ]),
                        //Text(DateFormat('20yy/M/d H:m').format(postList[index].postTime!.toDate()))//year:month/day hour:minute
                      ],
                    ),
                    Text(post.text),
                  ],
                ),
              ),
            ),
          ])));
}

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.deepPurple)),
        onPressed: onPressed,
        child: child,
      );
}
