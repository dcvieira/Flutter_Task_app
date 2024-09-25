import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/models/task_model.dart';

class SupabaseTasksRepository {
  Future<List<Task>> fetchTasks() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('tasks').select();
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
}
