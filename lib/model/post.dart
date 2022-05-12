import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  String id;
  String userId;
  String roomId;
  String text;
  Timestamp? postTime;//FirebaseだとDataFrameができない

  Post({this.id = '',this.userId = '',this.roomId = '',this.text = '',this.postTime});
}