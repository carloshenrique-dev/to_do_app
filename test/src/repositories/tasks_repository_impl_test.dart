import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:to_do_app/src/to_do_feature/task.dart';
import 'package:to_do_app/src/to_do_feature/task_controller.dart';

void main() {
  final task = Task(
    id: 'task1',
    name: 'Task 1',
    priority: Priority.medium.name,
    dateTime: DateTime.now(),
    isCompleted: false,
  );

  const expectedDumpAfterDelete = '''{
  "tasks": {}
}''';

  group('Task controller tests', () {
    test('deletes document within collection', () async {
      final instance = FakeFirebaseFirestore();
      final tasks = instance.collection('tasks').doc('task1');
      await tasks.set(task.toJson());
      await tasks.delete();
      expect(instance.dump(), expectedDumpAfterDelete);
    });

    test('adds a new task', () async {
      final instance = FakeFirebaseFirestore();
      final tasks = instance.collection('tasks');

      // Add a task to the collection
      final addedTaskRef = await tasks.add(task.toJson());
      final addedTaskSnapshot = await addedTaskRef.get();

      // Extract task data from the added document
      final addedTaskData = addedTaskSnapshot.data();
      final addedTaskName = addedTaskData!['name'];
      final addedTaskPriority = addedTaskData['priority'];
      final addedTaskIsCompleted = addedTaskData['isCompleted'];

      // Validate the presence and correctness of task fields
      expect(addedTaskName, equals('Task 1'));
      expect(addedTaskPriority, equals('medium'));
      expect(addedTaskIsCompleted, equals(false));
    });

    test('updates an existing task', () async {
      final instance = FakeFirebaseFirestore();
      final tasks = instance.collection('tasks');

      // Add a task to the collection
      final addedTaskRef = await tasks.add(task.toJson());

      // Mock the updated task data
      final updatedTaskData = {
        'name': 'Updated Task',
        'priority': 'high',
        'isCompleted': true,
      };

      // Update the task in the collection
      await addedTaskRef.update(updatedTaskData);

      // Retrieve the updated task from Firestore
      final updatedTaskSnapshot = await addedTaskRef.get();
      final updatedTaskDataFromFirestore = updatedTaskSnapshot.data();

      // Validate the updated task fields
      expect(updatedTaskDataFromFirestore!['name'], equals('Updated Task'));
      expect(updatedTaskDataFromFirestore['priority'], equals('high'));
      expect(updatedTaskDataFromFirestore['isCompleted'], equals(true));
    });

    test('returns a list of tasks', () async {
      final instance = FakeFirebaseFirestore();
      final tasks = instance.collection('tasks');

      // Add multiple tasks to the collection
      final taskDataList = [
        {
          'name': 'Task 1',
          'priority': 'low',
          'isCompleted': false,
          'dateTime': DateTime.now().toIso8601String()
        },
        {
          'name': 'Task 2',
          'priority': 'medium',
          'isCompleted': true,
          'dateTime': DateTime.now().toIso8601String()
        },
        {
          'name': 'Task 3',
          'priority': 'high',
          'isCompleted': false,
          'dateTime': DateTime.now().toIso8601String()
        },
      ];

      for (final taskData in taskDataList) {
        await tasks.add(taskData);
      }

      // Retrieve the list of tasks from Firestore
      final taskSnapshotList = await tasks.get();
      final taskListFromFirestore = taskSnapshotList.docs
          .map((doc) => Task.fromJson(doc.data()))
          .toList();

      // Validate the returned list of tasks
      expect(taskListFromFirestore.length, equals(taskDataList.length));

      // Validate each task in the list
      for (var i = 0; i < taskDataList.length; i++) {
        expect(taskListFromFirestore[i].name, equals(taskDataList[i]['name']));
        expect(taskListFromFirestore[i].priority,
            equals(taskDataList[i]['priority']));
        expect(taskListFromFirestore[i].isCompleted,
            equals(taskDataList[i]['isCompleted']));
      }
    });
  });
}
