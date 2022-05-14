import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/post.dart';
import 'package:flutter_testing/model/subject.dart';

// 【グローバル変数置き場】
class Vars {
  // static: シングルトンとなる。
  static Account? myAccount = Account();
  static List<Subject>? subjectList = [];
  static List<Post>? postList = [];
}
