import 'package:to_do_app/src/to_do_feature/task.dart';

abstract class TasksRepository {
  Future<List<Task>> loadTasks();
  Future<bool> createTask(Task task);
  Future<bool> removeTask(String id);
  Future<bool> updateTask(Task task);
}
