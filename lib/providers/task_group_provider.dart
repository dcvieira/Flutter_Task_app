import 'package:flutter/material.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/repository/supabase_tasks_repository.dart';

class TaskGroupProvider extends ChangeNotifier {
  final SupabaseTasksRepository _taskRepo = SupabaseTasksRepository();

  List<TaskGroupWithCounts> _taskGroupsWithCounts = [];
  List<TaskGroupWithCounts> get taskGroupsWithCounts => _taskGroupsWithCounts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TaskGroup? selectedTaskGroup;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _setErrorMessage([String? message]) {
    _errorMessage = message;
    notifyListeners();
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

  Future<void> createTaskGroup(TaskGroup taskGroup) async {
    try {
      await _taskRepo.createTaskGroup(taskGroup);
      _taskGroupsWithCounts.add(TaskGroupWithCounts(
        taskGroup: taskGroup,
        totalTasks: 0,
        completedTasks: 0,
      ));
      _setErrorMessage();
    } catch (e) {
      _setErrorMessage('Erro ao criar grupo de tarefas');
    }
  }

  Future<void> updateTaskGroup(TaskGroup taskGroup) async {
    try {
      await _taskRepo.updateTaskGroup(taskGroup);

      final index = _taskGroupsWithCounts
          .indexWhere((t) => t.taskGroup.id == taskGroup.id);
      if (index != -1) {
        _taskGroupsWithCounts[index].taskGroup = taskGroup;
        selectedTaskGroup = taskGroup;
        _setErrorMessage();
      }
    } catch (e) {
      _setErrorMessage('Erro ao criar grupo de tarefas');
    }
  }

  Future<void> deleteTaskGroup(String id) async {
    try {
      await _taskRepo.deleteTaskGroup(id);
      _taskGroupsWithCounts.removeWhere((task) => task.taskGroup.id == id);
      _setErrorMessage();
      notifyListeners();
    } catch (e) {
      _setErrorMessage('Erro ao excluir tarefa');
    }
  }
}
