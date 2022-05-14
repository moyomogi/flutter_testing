// async
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_testing/main.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/post.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/utils/vars.dart';

//todo ルームに入るときにroomIdごとにPost取得してPostList作成する
//todo subjectListをFirestoreから取得
//todo 投稿をUI上に反映させる(アカウント関係の処理ができてないときついかも)
//todo ヒューマンコンピュータインタラクション課題
//todo ソフトウェア工学第4回課題
//todo GithubDesktopの記事書く

// 【async 関数置き場】
class Firestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final usersRef = _firestoreInstance.collection('users');
  static final subjectsRef = _firestoreInstance.collection('subjects');
  static final postsRef = _firestoreInstance.collection('posts');

  static Future<dynamic> setUser(Account newAccount) async {
    // ApplicationState.myAccount = newAccount;
    try {
      /*final docId = await usersRef.add({});
      print(docId.id);*/
      await usersRef.doc(newAccount.internalId).set({
        'internalId': newAccount.internalId,
        'userid': newAccount.userId,
        'name': newAccount.name,
        'imagePath': newAccount.imagePath,
        'undergraduate': newAccount.undergraduate,
        'subjectIds': newAccount.subjectIds,
      });
      print("新アカウント作成完了");
      return true;
    } catch (e) {
      print("アカウント作成に失敗しました");
      return false;
    }
  }

  static Future<dynamic> getUser(String internalId) async {
    try {
      DocumentSnapshot documentSnapshot = await usersRef.doc(internalId).get();
      print("documentSnapshot: $documentSnapshot");
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      print("data: $data");
      List<String> undergraduate =
          List<String>.from(data['undergraduate'] as List);
      List<String> subjectIds = List<String>.from(data['subjectIds'] as List);

      Vars.myAccount = Account(
        internalId: data['internalId'],
        name: data['name'],
        userId: data['userid'],
        undergraduate: undergraduate,
        subjectIds: subjectIds,
        imagePath: data['imagePath'],
      );
      print("ユーザー取得完了");
      return true;
    } on FirebaseException catch (e) {
      print("ユーザー取得失敗: $e");
      return false;
    }
  }

  static Future<void> addPost(Post newPost) async {
    try {
      final docRef = await postsRef.add({});
      await postsRef.doc(docRef.id).set({
        'id': docRef.id,
        'name': newPost.userId,
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
  /*static Future<List<Post>> getPosts(String roomId) async {
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
          postList.add(
            Post(
              id: doc.data()['id'] as String,
              postTime: doc.data()['postTime'] as Timestamp,
              roomId: doc.data()['roomId'] as String,
              text: doc.data()['text'] as String,
              userId: doc.data()['userId'] as String,
            ),
          );
        }
      });
    } on FirebaseException catch (_) {
      debugPrint("posts 取得エラー");
    }
    return _postList;
  }*/

  static Future<dynamic> updateUser(Account updateAccount) async {
    try {
      usersRef.doc(updateAccount.internalId).update({
        'name': updateAccount.name,
        'userId': updateAccount.userId,
        'undergraduate': updateAccount.undergraduate,
        'subjectIds': updateAccount.subjectIds,
      });
      print("アカウントの情報更新");
      return true;
    } on FirebaseException catch (e) {
      print("アカウントの情報更新失敗");
      return false;
    }
  }

  static Future<List<Subject>> getSubjectList(List<String> subjectIds) async {
    List<Subject> subjectList = [];
    try {
      // Get all rooms whose subject is contained in the subjectIds.
      FirebaseFirestore.instance
          .collection('subjects')
          .where('subjectId', whereIn: subjectIds)
          .orderBy('postTime', descending: true)
          .snapshots()
          .listen((snapshot) {
        for (final doc in snapshot.docs) {
          subjectList.add(
            Subject(
              id: doc.data()['id'] as String,
              name: doc.data()['name'] as String,
              professors: doc.data()['professors'] as List<String>,
              dayOfTheWeek: doc.data()['dayOfTheWeek'] as List<String>,
              grade: doc.data()['grade'] as int,
            ),
          );
        }
      });
    } on FirebaseException catch (_) {
      debugPrint("posts 取得エラー");
    }
    return subjectList;
  }
}
