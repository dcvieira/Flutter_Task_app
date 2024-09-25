import 'package:uuid/uuid.dart';

class Task {
  final String id;
  final String title;
  final String subtitle;
  final DateTime date;
  final bool isCompleted;

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
        isCompleted: isCompleted,
      );

  Task copyWith({
    String? id,
    String? title,
    String? subtitle,
    DateTime? date,
    bool? isCompleted,
  }) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        date: date ?? this.date,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      id: data['id'],
      title: data['title'],
      subtitle: data['subtitle'],
      date: DateTime.parse(data['date']),
      isCompleted: data['is_completed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'date': date.toIso8601String(),
      'is_completed': isCompleted,
    };
  }
}
