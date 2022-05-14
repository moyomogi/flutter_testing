import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_testing/main.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/post.dart';

//todo ルームに入るときにroomIdごとにPost取得してPostList作成する
//todo subjectListをFirestoreから取得
//todo 投稿をUI上に反映させる(アカウント関係の処理ができてないときついかも)
//todo ヒューマンコンピュータインタラクション課題
//todo ソフトウェア工学第4回課題
//todo GithubDesktopの記事書く

class Firestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final userRef = _firestoreInstance.collection('users');
  static final subjectsRef = _firestoreInstance.collection('subjects');
  static final postsRef = _firestoreInstance.collection('posts');

  static Future<void> setAccount(Account newAccount) async {
    // ApplicationState.myAccount = newAccount;
    try {
      final docRef = await userRef.add({});
      debugPrint(docRef.id);
      await userRef.doc(docRef.id).set({
        'id': docRef.id,
        'userId': newAccount.userId, // yatapngn
        'name': newAccount.name,
        'imagePath': newAccount.imagePath,
        'undergraduate': newAccount.undergraduate,
        'subjectIds': newAccount.subjectIds,
      });
      debugPrint("新アカウント作成完了");
    } catch (e) {
      debugPrint("アカウント作成に失敗しました");
    }
  }

  // Future<void> getUser(String id) async {
  //   try {
  //     DocumentSnapshot documentSnapshot = await userRef.doc(id).get();
  //     Map<String, dynamic> data =
  //         documentSnapshot.data() as Map<String, dynamic>;
  //     myAccount = Account(
  //         id: id,
  //         userId: data['userId'],
  //         imagePath: data['imagePath'],
  //         undergraduate: data['undergraduate'],
  //         subjectIds: data['subjectIds']);
  //   } catch (e) {
  //     debugPrint("ユーザー取得失敗");
  //   }
  //   // return myAccount;
  // }

  static Future<void> addPost(Post newPost) async {
    try {
      final docRef = await postsRef.add({});
      await postsRef.doc(docRef.id).set({
        'id': docRef.id,
        'userId': newPost.userId,
        'roomId': newPost.roomId,
        'text': newPost.text,
        'postTime': Timestamp.now(),
      });
      debugPrint("投稿完了");
    } on FirebaseException catch (_) {
      debugPrint("投稿エラー");
    }
  }

  // 【Dart】Futureクラスとasync/awaitの基本的な使い方
  // https://zenn.dev/iwaku/articles/2020-12-29-iwaku
  static Future<List<Post>> getPosts(String roomId) async {
    List<Post> _postList = [];
    try {
      // Get all posts whose roomId is equal to roomId
      FirebaseFirestore.instance
          .collection('posts')
          .where('roomId', isEqualTo: roomId)
          .orderBy('postTime', descending: true)
          .snapshots()
          .listen((snapshot) {
        // post:
        // - id: String
        // - postTime: Timestamp
        // - roomId: String
        // - text: String
        // - userId: String
        for (final doc in snapshot.docs) {
          _postList.add(
            Post(
              id: doc.data()['id'] as String,
              postTime: doc.data()['postTime'] as Timestamp,
              roomId: doc.data()['roomId'] as String,
              text: doc.data()['text'] as String,
              userId: doc.data()['userId'] as String,
            ),
          );
          // snapshot.docs.forEach((doc) {
          //   _postList.add(
          //     Post(
          //       id: doc.data()['id'] as int,
          //       postTime: doc.data()['postTime'] as String,
          //       roomId: doc.data()['roomId'] as int,
          //       text: doc.data()['text'] as String,
          //       userId: doc.data()['userId'] as int,
          //     ),
          //   );
          //   );
        }
      });
    } on FirebaseException catch (_) {
      debugPrint("posts 取得エラー");
    }
    return _postList;
  }
}
