import 'package:flutter/material.dart';

import '../task.dart';
import '../task_controller.dart';
import '../task_view.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.item,
    required this.taskController,
  });

  final Task item;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        item.name,
        style: TextStyle(
          decoration: item.isCompleted ? TextDecoration.lineThrough : null,
          color: item.isCompleted ? Colors.grey : null,
        ),
      ),
      leading: Checkbox(
        value: item.isCompleted,
        onChanged: (value) async {
          final task = item.copyWith(isCompleted: value);
          await taskController.updateTask(task);
        },
      ),
      onTap: () {
        Navigator.restorablePushNamed(
          context,
          TaskView.routeName,
        );
        taskController.setTask(item);
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.restorablePushNamed(
                context,
                TaskView.routeName,
              );
              taskController.setTask(item);
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () async => await taskController.removeTask(item),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
