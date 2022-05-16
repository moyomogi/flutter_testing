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
      name: '線形代数1 /必:工〈機械〉2',
    ),
    Subject(
      id: 'KfwqLfSu84NT8g7fOmMK',
      name: '日本国憲法',
    ),
    Subject(
      id: 'MpstdlraBgynY6HcBfSG',
      name: '線形代数1 /必:工〈電物〉2',
    ),
    Subject(
      id: 'Q7iKMR6YaDPlG5B0MWbL',
      name: 'アルゴリズムとデータ構造',
    ),
    Subject(
      id: 'X22wSIkPMEYXT3TOSGXc',
      name: '情報工学実験Ⅰ',
    ),
    Subject(
      id: 'YcSIIR9PfEEmyWcNvk4h',
      name: '言語学入門',
    ),
    Subject(
      id: 'dm2eXMzsBDzIrD9TcXsH',
      name: '心理学入門',
    ),
    Subject(
      id: 'kPxqWWOFJ057btLcRswF',
      name: '人工知能',
    ),
    Subject(
      id: 'l9knxxgdS463m6jTTOIw',
      name: '線形代数1 /必:工〈航空・化工〉',
    ),
    Subject(
      id: 'mSIQyq0eXmoft7dr0bey',
      name: '政治学入門',
    ),
    Subject(
      id: 'qcwYvXLdK1oDksVPSz8x',
      name: '線形代数1 /必:工〈電物〉1',
    ),
    Subject(
      id: 'rfd8jhmtFLnZxVi5pp49',
      name: '東洋史の見方',
    ),
  ];
  static List<Post>? postList = [];
  static List<Subject>? allSubjectList = [];
}
