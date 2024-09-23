import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/models/task_model.dart';

class SupabaseTasksRepository {
  //Future<List<Task>> listTasks() {}

  Future createTask(Task task) async {
    final supabase = Supabase.instance.client;
    await supabase.from('tasks').insert({
      'id': task.id,
      'title': task.title,
      'subttile': task.subtitle,
      'isCompleted': task.isCompleted,
      'date': task.date,
    });
  }

  Future editTask(Task task) async {
    final supabase = Supabase.instance.client;
    await supabase.from('tasks').update({
      'title': task.title,
      'subttile': task.subtitle,
      'isCompleted': task.isCompleted,
      'date': task.date,
    }).eq('id', task.id);
  }

  Future deleteTask(String taskId) async {
    final supabase = Supabase.instance.client;
    await supabase.from('tasks').delete().eq('id', taskId);
  }
}
