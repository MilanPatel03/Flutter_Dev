import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app_mks/ui/screens/add_task_screen.dart';

import '../viewmodels/task_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TaskViewModel vm;

  @override
  void initState() {
    super.initState();
    vm = Provider.of<TaskViewModel>(context, listen: false);
    vm.loadTasks();
  }

  String formatDate(DateTime d) {
    return "${d.day}/${d.month}/${d.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),

        actions: [
          PopupMenuButton<TaskFilter>(
            onSelected: (f) {
              context.read<TaskViewModel>().setFilter(f);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: TaskFilter.all, child: Text("All")),
              PopupMenuItem(value: TaskFilter.completed, child: Text("Completed")),
              PopupMenuItem(value: TaskFilter.pending, child: Text("Pending")),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: const [
                  Icon(Icons.filter_list, size: 20),
                  SizedBox(width: 3),
                  Text("Filter"),
                ],
              ),
            ),
          ),

          PopupMenuButton<TaskSort>(
            onSelected: (s) {
              context.read<TaskViewModel>().setSort(s);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: TaskSort.createdAt, child: Text("Created")),
              PopupMenuItem(value: TaskSort.dueDate, child: Text("Due Date")),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: const [
                  Icon(Icons.sort, size: 20),
                  SizedBox(width: 2),
                  Text("Sort"),
                ],
              ),
            ),
          ),
        ],
      ),

      body: Consumer<TaskViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.tasks.isEmpty) {
            return const Center(child: Text('No tasks'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: vm.tasks.length,
            itemBuilder: (context, i) {
              final t = vm.tasks[i];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddTaskScreen(task: t),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Colors.grey.shade300,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: t.isCompleted,
                            onChanged: (_) {
                              vm.toggleComplete(t);
                            },
                          ),

                          Expanded(
                            child: Text(
                              t.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: t.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                          ),

                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              vm.deleteTask(t.id);
                            },
                          ),
                        ],
                      ),

                      Text(t.description),

                      const SizedBox(height: 6),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Due: ${formatDate(t.dueDate)}",
                              style: const TextStyle(color: Colors.red)),
                          Text("Created: ${formatDate(t.createdAt)}",
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          t.isCompleted ? "Completed" : "Pending",
                          style: TextStyle(
                            color: t.isCompleted ? Colors.green : Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddTaskScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}