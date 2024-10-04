import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_group_provider.dart';
import 'package:todo_app/repository/supabase_tasks_repository.dart';

class TaskProvider with ChangeNotifier {
  final SupabaseTasksRepository _taskRepo = SupabaseTasksRepository();
  final TaskGroupProvider _taskGroupProvider;

  TaskProvider(this._taskGroupProvider);

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

  Future<void> fetchTasks(String groupId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await _taskRepo.fetchTasksByGroup(groupId);
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
      _taskGroupProvider.fetchTasksGroupWithCounts();
      _setErrorMessage();
    } catch (e) {
      _setErrorMessage('Erro ao adicionar tarefa: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _taskRepo.deleteTask(id);
      _tasks.removeWhere((task) => task.id == id);
      _taskGroupProvider.fetchTasksGroupWithCounts();
      _setErrorMessage();
    } catch (e) {
      _setErrorMessage('Erro ao excluir tarefa');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _taskRepo.updateTask(task);
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
        _taskGroupProvider.fetchTasksGroupWithCounts();
        _setErrorMessage();
      }
    } catch (e) {
      _setErrorMessage('Erro ao atualizar tarefa');
    }
  }
}
