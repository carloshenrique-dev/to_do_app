import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/src/to_do_feature/task_controller.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final settingsController = SettingsController(SettingsService());
  final tasksController = TaskController();

  await settingsController.loadSettings();
  await tasksController.loadTasks();

  runApp(MyApp(
    settingsController: settingsController,
    taskController: tasksController,
  ));
}
