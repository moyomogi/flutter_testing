import 'package:flutter_testing/model/account.dart';
import 'package:flutter_testing/model/post.dart';
import 'package:flutter_testing/model/subject.dart';

// 【グローバル変数置き場】
class Vars {
  // static: シングルトンとなる。
  static Account? myAccount = Account();
  static List<Subject>? subjectList = [
    Subject(
        id: '15HiJNcV91Mi5qV0zmvF',
        name: 'アルゴリズムとデータ構造',
        professors: ['宇野'],
        dayOfTheWeek: ['Mon3'],
        grade: 2),
    Subject(
        id: '5n0A7c3Ek2lLc7gMSguu',
        name: '人工知能',
        professors: ['黄瀬', '内海'],
        dayOfTheWeek: ['Wed3'],
        grade: 3),
    Subject(
        id: 'KfwqLfSu84NT8g7fOmMK',
        name: '情報工学実験',
        professors: ['生方', '内海'],
        dayOfTheWeek: ['Wed3'],
        grade: 3),
    Subject(
        id: 'MpstdlraBgynY6HcBfSG',
        name: '情報工学演習',
        professors: ['生方', '本多'],
        dayOfTheWeek: ['Thu3'],
        grade: 3),
    Subject(
        id: 'Q7iKMR6YaDPlG5B0MWbL',
        name: 'データ解析',
        professors: ['林'],
        dayOfTheWeek: ['Fri3'],
        grade: 3)
  ];
  static List<Post>? postList = [];
}
