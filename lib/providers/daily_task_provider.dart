import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/repository/supabase_tasks_repository.dart';

class DailyTaskProvider with ChangeNotifier {
  final SupabaseTasksRepository _taskRepo = SupabaseTasksRepository();

  // DateTime _selectedDate = DateTime.now();
  // DateTime get selectedDate => _selectedDate;

  // void selectDate(DateTime date) {
  //   _selectedDate = date;
  //   notifyListeners();
  //   //await fetchDailyTasks();
  // }

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  int get totalTasksDone => _tasks.where((t) => t.isCompleted).length;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setErrorMessage([String? message]) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<void> fetchDailyTasks(DateTime date) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await _taskRepo.fetchTasksByDate(date);
      _setErrorMessage();
    } catch (e) {
      _setErrorMessage('Erro ao buscar tarefas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
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
      _setErrorMessage('Erro ao atualizar tarefa');
    }
  }
}
