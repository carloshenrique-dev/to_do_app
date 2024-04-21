import 'package:flutter/material.dart';
import 'package:to_do_app/src/to_do_feature/task_controller.dart';

import 'task.dart';
import 'widgets/priority_dropdown_button.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.taskController,
  });

  static const routeName = '/new_task';

  final TaskController taskController;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _textEditingController;
  late Priority _selectedPriority;

  @override
  void initState() {
    super.initState();
    setState(() {
      _textEditingController =
          TextEditingController(text: widget.taskController.task?.name ?? '');
      _selectedPriority =
          PriorityExtension.fromString(widget.taskController.task?.priority) ??
              Priority.low;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getViewTitle(widget.taskController.task)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            widget.taskController.setTask(null);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _textEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter task name',
                ),
              ),
              PriorityDropdownButton(
                initialValue: _selectedPriority,
                onChanged: (Priority newValue) {
                  setState(() {
                    _selectedPriority = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await createOrEditTask(widget.taskController.task);
            if (context.mounted) {
              Navigator.pop(context);
            }
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  String getViewTitle(Task? task) {
    if (task != null) {
      return 'Edit task';
    }
    return 'New task';
  }

  Task? getTask(Object? object) {
    if (object != null) {
      return Task.fromJson(object as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> createOrEditTask(Task? task) async {
    if (task != null) {
      task = task.copyWith(
        name: _textEditingController.text,
        priority: _selectedPriority.name,
        dateTime: DateTime.now(),
      );

      await widget.taskController.updateTask(
        task,
      );
    } else {
      await widget.taskController.createTask(
        Task(
          name: _textEditingController.text,
          dateTime: DateTime.now(),
          priority: _selectedPriority.name,
        ),
      );
    }
  }
}
