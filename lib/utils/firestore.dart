import 'dart:html';
import 'package:flutter_testing/model/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_testing/model/post.dart';
import 'package:flutter_testing/model/subject.dart';


//todo ルームに入るときにroomIdごとにPost取得してPostList作成する
//todo subjectListをFirestoreから取得
//todo 投稿をUI上に反映させる(アカウント関係の処理ができてないときついかも)
//todo ヒューマンコンピュータインタラクション課題
//todo ソフトウェア工学第4回課題
//todo GithubDesktopの記事書く


class Firestore {
  static final _firestoreInstance = FirebaseFirestore.instance;
  static final userRef =  _firestoreInstance.collection('users');
  static final subjectsRef = _firestoreInstance.collection('subjects');
  static final postsRef = _firestoreInstance.collection('posts');

  static Future<dynamic> setUser(Account newAccount) async{
    try{
      final docId = await userRef.add({});
      print(docId.id);
      await userRef.doc(docId.id).set({
        'internalId': docId.id,
        'userid' : newAccount.userId,
        'name': newAccount.name,
        'imagePath': newAccount.imagePath,
        'undergraduate': newAccount.undergraduate,
        'subjectIds': newAccount.subjectIds,
      });
      print("新アカウント作成完了");
    }catch(e){
      print("アカウント作成に失敗しました");
    }
  }

  static Future<dynamic> getUser(String internalId) async{
    try{
      DocumentSnapshot documentSnapshot = await userRef.doc(internalId).get();
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Account myAccount = Account(
        internalId: internalId,
        userId: data['userId'],
        imagePath: data['imagePath'],
        undergraduate: data['undergraduate'],
        subjectIds: data['subjectIds']
      );
    }catch(e){
      print("ユーザー取得失敗");
    }
  }

  static Future<void> addPost(Post newPost) async{
    try{
      final docId = await postsRef.add({});
      await postsRef.doc(docId.id).set({
        'id': docId.id,
        'userid' : newPost.userId,
        'roomId': newPost.roomId,
        'text': newPost.text,
        'postTime': Timestamp.now(),
      });
      print("投稿完了");
    } on FirebaseException catch(e){
      print("投稿エラー");
      
    }
  }

  static Future<void> getPost(String roomId) async{
    try{
      
    } on FirebaseException catch(e){
      print("post取得エラー");
    }
  }

  
}