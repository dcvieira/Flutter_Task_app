import 'package:flutter/material.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/repository/supabase_tasks_repository.dart';

class TaskProvider with ChangeNotifier {
  final SupabaseTasksRepository _taskRepo = SupabaseTasksRepository();

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  List<TaskGroupWithCounts> _taskGroupsWithCounts = [];
  List<TaskGroupWithCounts> get taskGroupsWithCounts => _taskGroupsWithCounts;

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
    //notifyListeners();
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

  Future<void> fetchTasksGroupWithCounts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _taskGroupsWithCounts = await _taskRepo.getTaskGroupsWithCounts();
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
      _setErrorMessage('Erro ao excluir tarefa');
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

  Future<void> createTaskGroup(
      TaskGroup taskGroup) async {
    try {
      await _taskRepo.createTaskGroup(taskGroup);
      _taskGroupsWithCounts.add(TaskGroupWithCounts(
        id: taskGroup.id,
        name: taskGroup.name,
        icon: taskGroup.icon,
        color: taskGroup.color,
        totalTasks: 0,
        completedTasks: 0,
      ));
      _setErrorMessage();
    } catch (e) {
      _setErrorMessage('Erro ao criar grupo de tarefas');
    }
  }

    Future<void> deleteTaskGroup(String id) async {
    try {
      await _taskRepo.deleteTaskGroup(id);
      _taskGroupsWithCounts.removeWhere((task) => task.id == id);
      _setErrorMessage();
      notifyListeners();
    } catch (e) {
      _setErrorMessage('Erro ao excluir tarefa');
    }
  }

}
