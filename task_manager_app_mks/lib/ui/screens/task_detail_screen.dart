import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  static const routeName = '/taskDetail';

  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(task.description),

            const SizedBox(height: 20),
            Text("Due: ${task.dueDate.toLocal().toString().split(' ')[0]}",),

            const SizedBox(height: 10),
            Text(task.isCompleted ? "Completed" : "Pending",),
          ],
        ),
      ),
    );
  }
}