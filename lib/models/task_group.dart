import 'package:uuid/uuid.dart';

class TaskGroup {
  final String id;
  final String name;
  final int color;
  final int icon;

  TaskGroup({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  factory TaskGroup.fromMap(Map<String, dynamic> json) {
    return TaskGroup(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'icon': icon,
    };
  }

  factory TaskGroup.create({
    required String name,
    required int color,
    required int icon,
  }) =>
      TaskGroup(
        id: const Uuid().v1(),
        name: name,
        color: color,
        icon: icon,
      );

  TaskGroup copyWith({
    String? id,
    String? name,
    int? color,
    int? icon,
  }) =>
      TaskGroup(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        icon: icon ?? this.icon,
      );
}

class TaskGroupWithCounts {
  final String id;
  final String name;
  final int color;
  final int icon;
  final int totalTasks;
  final int completedTasks;

  TaskGroupWithCounts({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
    required this.totalTasks,
    required this.completedTasks,
  });

  TaskGroupWithCounts copyWith({
    String? id,
    String? name,
    int? color,
    int? icon,
    int? totalTasks,
    int? completedTasks,
  }) =>
      TaskGroupWithCounts(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        icon: icon ?? this.icon,
        totalTasks: totalTasks ?? this.totalTasks,
        completedTasks: completedTasks ?? this.completedTasks,
      );
}
