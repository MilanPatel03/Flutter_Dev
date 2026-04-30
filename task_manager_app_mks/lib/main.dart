import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'ui/screens/add_task_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/task_detail_screen.dart';
import 'ui/viewmodels/task_view_model.dart';

import 'data/repositories/task_repository_impl.dart';
import 'data/services/task_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('tasksBox');
  final service = TaskService();
  final repo = TaskRepositoryImpl(taskService: service);

  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskViewModel(repository: repo),
      child: const MyApp(),),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',

      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),

      initialRoute: '/',

      routes: {
        '/': (context) => const HomeScreen(),
        '/addTask': (context) => const AddTaskScreen(),
        '/taskDetail': (context) => const TaskDetailScreen(),
      },
    );
  }
}