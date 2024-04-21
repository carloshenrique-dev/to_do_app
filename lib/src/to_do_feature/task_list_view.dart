import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings/settings_view.dart';
import 'task_view.dart';
import 'task_controller.dart';
import 'widgets/task_item.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key, required this.taskController});

  static const routeName = '/';

  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskController>.value(
      value: taskController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: Consumer<TaskController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (!controller.isLoading &&
                controller.tasksList.isEmpty &&
                controller.completedTasks.isEmpty) {
              return const Center(
                child: Text(
                  'No tasks to show :(',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              );
            }

            return ListView(
              children: [
                Visibility(
                  visible: taskController.tasksList.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Pending Tasks',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        restorationId: 'pendingTaskListView',
                        itemCount: taskController.tasksList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = taskController.tasksList[index];

                          return TaskItem(
                              item: item, taskController: taskController);
                        },
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: taskController.completedTasks.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Completed Tasks',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        restorationId: 'completedTaskListView',
                        itemCount: taskController.completedTasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = taskController.completedTasks[index];

                          return TaskItem(
                              item: item, taskController: taskController);
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.restorablePushNamed(
              context,
              TaskView.routeName,
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
