class Subject {
  String id;
  String name;
  List<String> professors;
  List<String> dayOfTheWeek; // Listにしてぇ～
  int grade;

  Subject({
    this.id = '',
    this.name = '',
    required this.professors,
    required this.dayOfTheWeek,
    this.grade = 0,
  });
}
