import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/src/repositories/tasks_repository.dart';
import 'package:to_do_app/src/to_do_feature/task.dart';

class TasksRepositoryImpl implements TasksRepository {
  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Future<bool> createTask(Task task) async {
    try {
      return await tasksCollection
          .add(task.toJson())
          .then((value) => true)
          .catchError((error) {
        log('Error to create task: $error');
        return false;
      });
    } catch (e, s) {
      log('Exception to create task: $e', stackTrace: s);
      return false;
    }
  }

  @override
  Future<List<Task>> loadTasks() async {
    try {
      QuerySnapshot querySnapshot = await tasksCollection.get();
      List<Task> taskList = querySnapshot.docs.map((doc) {
        var task = Task.fromJson(
          doc.data() as Map<String, dynamic>,
        );

        task = task.copyWith(id: doc.id);

        return task;
      }).toList();

      return taskList;
    } catch (e, s) {
      log('Exception to load tasks: $e', stackTrace: s);
      return [];
    }
  }

  @override
  Future<bool> removeTask(String id) async {
    try {
      return await tasksCollection
          .doc(id)
          .delete()
          .then((value) => true)
          .catchError((error) {
        log('Error to create task: $error');
        return false;
      });
    } catch (e, s) {
      log('Exception to create task: $e', stackTrace: s);
      return false;
    }
  }

  @override
  Future<bool> updateTask(Task task) async {
    try {
      return await tasksCollection
          .doc('${task.id}')
          .update(task.toJson())
          .then((value) => true)
          .catchError((error) {
        log('Error to update task: $error');
        return false;
      });
    } catch (e, s) {
      log('Exception to update task: $e', stackTrace: s);
      return false;
    }
  }
}
