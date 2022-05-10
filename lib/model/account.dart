class Account {
  String internalId;//FireStoreで管理用
  String userId;
  String name;//ユーザー名
  String undergraduate;//Listにしてぇ～
  //int maxId = 20;
  String subjectIds;//Listにしてぇ～
  String imagePath;




  Account({this.internalId = '',this.userId = '',this.name = '',this.undergraduate = '',this.subjectIds = '',this.imagePath = '',});

}