import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_testing/main.dart';
import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/post.dart';
import 'package:flutter_testing/model/subject.dart';
import 'package:flutter_testing/utils/authentication.dart';

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

  static Future<dynamic> setUser(Account newAccount) async {
    // ApplicationState.myAccount = newAccount;
    try {
      /*final docId = await userRef.add({});
      print(docId.id);*/
      await userRef.doc(newAccount.internalId).set({
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
      DocumentSnapshot documentSnapshot = await userRef.doc(internalId).get();
      print("documentSnapshot: $documentSnapshot");
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      print("data: $data");
      List<String> undergraduate = List<String>.from(data['undergraduate'] as List);
      List<String> subjectIds = List<String>.from(data['subjectIds'] as List);

      Account _myAccount = Account(
          internalId: data['internalId'],
          name: data['name'],
          userId: data['userid'],
          undergraduate: undergraduate,
          subjectIds: subjectIds,
          imagePath: data['imagePath'],
      );
      Authentication.myAccount = _myAccount;
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
  }*/

  static Future<dynamic> updateUser(Account updateAccount) async{
    try{
      
      userRef.doc(updateAccount.internalId).update({
        'name': updateAccount.name,
        'userId':updateAccount.userId,
        'undergraduate': updateAccount.undergraduate,
        'subjectIds': updateAccount.subjectIds,
      });
      print("アカウントの情報更新");
      return true;
    } on FirebaseException catch(e){
      print("アカウントの情報更新失敗");
      return false;
    }
  }
  //部屋に参加してツイートしてる垢のMap
  static Future<Map<String,Account>?> getPostUserMap(List<String> internalIds) async{
  Map<String,Account> map = {};
  try{
    await Future.forEach(internalIds, (String internalId) async{
      var doc = await userRef.doc(internalId).get();
      Map<String,dynamic> data = doc.data() as Map<String, dynamic>;
      List<String> undergraduate = List<String>.from(data['undergraduate'] as List);
      List<String> subjectIds = List<String>.from(data['subjectIds'] as List);
      Account postAccount = Account(
        internalId: internalId,
        userId: data['userid'],
        name: data['name'],
        imagePath: data['imagePath'],
        undergraduate: undergraduate,
        subjectIds: subjectIds
      );
      map[internalId] = postAccount;
    });
    print('投稿ユーザーの情報取得完了');
    return map;
  } on FirebaseException catch(e){
    print('投稿ユーザーの情報取得エラー');
    return null;
  }
}
}


