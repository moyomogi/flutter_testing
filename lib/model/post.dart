import 'dart:async'; // FutureOr
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // StatefulWidget

import 'package:flutter_testing/main.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/utils/widgets.dart';

class Post {
  Post(
      {required this.id,
      this.postTime,
      required this.roomId,
      this.text = '',
      required this.userId});
  final String id;
  final Timestamp? postTime; //FirebaseだとDataFrameができない
  final String roomId;
  final String text;
  final String userId;
}

// postList の内容を twitter 風に描画する
class PostList extends StatefulWidget {
  // Modify the following line 7
  const PostList(
      {required this.addPost, required this.postList, required this.myAccount});
  final FutureOr<void> Function(String userId, String subjectId, String text)
      addPost;
  final List<Post> postList; // new 7
  final Account myAccount;

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PostListState');
  final _controller = TextEditingController();

  // Modify the following line 7
  List<Post> _postList = [];
  List<Post> get postList => _postList;
  // 未代入
  Account _myAccount = Account();
  Account get myAccount => _myAccount;

  @override
  void initState() {
    super.initState();
    // Modify the following line 7
    _postList = widget.postList;
    _myAccount = widget.myAccount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // to here.
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Leave a message',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.addPost(
                          myAccount.userId, myAccount.userId, _controller.text);
                      _controller.clear();
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('SEND'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Modify from here 7
        ),
        const SizedBox(height: 8),
        for (Post post in widget.postList) Paragraph(post, myAccount),
        const SizedBox(height: 8),
      ],
      // to here.
    );
  }
}
