class Account {
  Account({
    this.internalId = '',
    this.userId = '',
    this.name = '',
    this.undergraduate = const [],
    this.subjectIds = const [],
    this.imagePath = '',
  });

  String internalId; //FireStoreで管理用
  String userId;
  String name; //ユーザー名
  List<String> undergraduate; //Listにしてぇ～
  //int maxId = 20;
  List<String> subjectIds; //Listにしてぇ～
  String imagePath;
}
