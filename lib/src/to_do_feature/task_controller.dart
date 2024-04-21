import 'package:flutter/material.dart';
import 'package:to_do_app/src/repositories/tasks_repository.dart';
import 'package:to_do_app/src/repositories/tasks_repository_impl.dart';

import 'task.dart';

enum Priority { low, medium, high }

extension PriorityExtension on Priority {
  // Convert a string to a Priority enum value
  static Priority? fromString(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'low':
        return Priority.low;
      case 'medium':
        return Priority.medium;
      case 'high':
        return Priority.high;
      default:
        return null;
    }
  }
}

class TaskController with ChangeNotifier {
  TaskController();

  final TasksRepository _tasksRepository = TasksRepositoryImpl();

  List<Task> _tasksList = [];
  List<Task> get tasksList => _tasksList;

  List<Task> _completedTasks = [];
  List<Task> get completedTasks => _completedTasks;

  bool isLoading = false;
  Task? task;

  // Load tasks from the repository
  Future<void> loadTasks() async {
    isLoading = true;

    final tasks = await _tasksRepository.loadTasks();

    // Separate incomplete and complete tasks
    final List<Task> incompleteTasks =
        tasks.where((task) => !task.isCompleted).toList();
    final List<Task> completeTasks =
        tasks.where((task) => task.isCompleted).toList();

    // Sort tasks by date and time
    incompleteTasks.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    completeTasks.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    _tasksList = incompleteTasks;
    _completedTasks = completeTasks;

    isLoading = false;
    notifyListeners();
  }

  // Create a new task
  Future<void> createTask(Task task) async {
    isLoading = true;
    notifyListeners();

    final result = await _tasksRepository.createTask(task);
    if (result) {
      await loadTasks();
      setTask(null);
    }
    isLoading = false;
    notifyListeners();
  }

  // Remove a task
  Future<void> removeTask(Task task) async {
    isLoading = true;
    notifyListeners();

    if (task.id != null) {
      final result = await _tasksRepository.removeTask(task.id!);
      if (result) {
        await loadTasks();
      }
    }
    isLoading = false;
    notifyListeners();
  }

  // Update a task
  Future<void> updateTask(Task task) async {
    isLoading = true;
    notifyListeners();

    final result = await _tasksRepository.updateTask(task);
    if (result) {
      await loadTasks();
      setTask(null);
    }
    isLoading = false;
    notifyListeners();
  }

  // Set the current task
  void setTask(Task? taskValue) {
    task = taskValue;
    notifyListeners();
  }
}
