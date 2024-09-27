import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/models/task_model.dart';

class SupabaseTasksRepository {
  Future<List<Task>> fetchTasksByGroup(String groupId) async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('tasks').select().eq('task_group_id', groupId);
    return response.map((task) => Task.fromMap(task)).toList();
  }

  Future createTask(Task task) async {
    final supabase = Supabase.instance.client;
    await supabase.from('tasks').insert(task.toMap());
  }

  Future updateTask(Task task) async {
    final supabase = Supabase.instance.client;
    await supabase.from('tasks').update(task.toMap()).eq('id', task.id);
  }

  Future deleteTask(String taskId) async {
    final supabase = Supabase.instance.client;
    await supabase.from('tasks').delete().eq('id', taskId);
  }

  Future<List<TaskGroupWithCounts>> getTaskGroupsWithCounts() async {
    final supabase = Supabase.instance.client;
    final taskGroups = await supabase.from('task_groups').select('''
        id,
        name,
        color,
        icon,
        tasks (
          id,
          is_completed
        )
      ''');

    final List<TaskGroupWithCounts> taskGroupsWithCounts =
        taskGroups.map((taskGroup) {
      final tasks = taskGroup['tasks'] as List;
      final completedTasks = tasks.where((task) => task['is_completed']).length;
      final totalTasks = tasks.length;
      return TaskGroupWithCounts(
        id: taskGroup['id'],
        name: taskGroup['name'],
        color: taskGroup['color'],
        icon: taskGroup['icon'],
        completedTasks: completedTasks,
        totalTasks: totalTasks,
      );
    }).toList();

    return taskGroupsWithCounts;
  }
}
