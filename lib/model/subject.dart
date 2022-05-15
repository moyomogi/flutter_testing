class Subject {
  String id;
  String name;
  List<String> professors;
  List<String> dayOfTheWeek; // Listにしてぇ～
  int grade;

  Subject({
    required this.id,
    required this.name,
    this.professors = const ['None'],
    this.dayOfTheWeek = const ['None'],
    this.grade = 0,
  });
}
