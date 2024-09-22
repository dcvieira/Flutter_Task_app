import 'package:uuid/uuid.dart';

class Task {
  String id;
  String title;
  String subtitle;
  DateTime date;
  bool isCompleted;

  Task(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.date,
      required this.isCompleted});

  factory Task.create({
    required String title,
    String? subtitle,
    DateTime? date,
    bool isCompleted = false,
  }) =>
      Task(
          id: const Uuid().v1(),
          title: title,
          subtitle: subtitle ?? '',
          date: date ?? DateTime.now(),
          isCompleted: isCompleted);
}
