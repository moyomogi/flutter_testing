class Account {
  String internalId;//FireStoreで管理用
  String userId;
  String name;//ユーザー名
  List<String> undergraduate;//Listにしてぇ～
  //int maxId = 20;
  List<String> subjectIds;//Listにしてぇ～
  String imagePath;




  Account({this.internalId = '',this.userId = '',this.name = '',required this.undergraduate,required this.subjectIds,this.imagePath = '',});

}