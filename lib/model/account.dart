class Account {
  String id;//FireStoreで管理用
  String name;//ユーザー名
  String imagePath;
  String selfIntroduction;
  String userId;
  DateTime? createdTime;
  DateTime? updatedTime;


  Account({this.id = '',this.name = '',this.imagePath = '',this.selfIntroduction = '',this.userId = '',this.createdTime,this.updatedTime});
  
}