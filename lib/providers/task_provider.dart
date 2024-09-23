import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/repository/supabase_tasks_repository.dart';

class TaskProvider with ChangeNotifier {
  final SupabaseTasksRepository _taskRepo = SupabaseTasksRepository();

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

   String? _errorMessage;
  String? get errorMessage => _errorMessage;

   void _setErrorMessage([String? message]) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await _taskRepo.fetchTasks();
        _setErrorMessage();
    } catch (e) {
       _setErrorMessage('Erro ao buscar tarefas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> addTask(Task task) async {
    try {
      await _taskRepo.createTask(task);
      _tasks.add(task);
       _setErrorMessage();
      notifyListeners();
    } catch (e) {
      _setErrorMessage('Erro ao adicionar tarefa: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _taskRepo.deleteTask(id);
      _tasks.removeWhere((task) => task.id == id);
      _setErrorMessage();
      notifyListeners();
    } catch (e) {
      _setErrorMessage('Erro ao excluir tarefa: $e');
    }
  }

    Future<void> updateTask(Task task) async {
    try {
      await _taskRepo.updateTask(task);
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
         _setErrorMessage();
        notifyListeners();
      }
    } catch (e) {
     _setErrorMessage('Erro ao atualizar tarefa: $e');
    }
  }
}
