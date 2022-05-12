class Subject{
  String id;
  String name;
  List<String> professers;
  List<String> dayOfTheWeek;//Listにしてぇ～
  int grade;

  Subject({this.id = '',this.name='',required this.professers,required this.dayOfTheWeek,this.grade= 0,});
}