import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository.dart';

enum TaskFilter { all, completed, pending }
enum TaskSort { dueDate, createdAt }

class TaskViewModel extends ChangeNotifier {
  final TaskRepository repository;

  TaskViewModel({required this.repository});

  final box = Hive.box('tasksBox');

  List<Task> _tasks = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TaskFilter _filter = TaskFilter.all;
  TaskSort _sort = TaskSort.createdAt;

  List<Task> get tasks {
    var list = [..._tasks];
    //filter methids
    if (_filter == TaskFilter.completed) {
      list = list.where((t) => t.isCompleted).toList();
    } else if (_filter == TaskFilter.pending) {
      list = list.where((t) => !t.isCompleted).toList();
    }

    //sorting
    if (_sort == TaskSort.dueDate) {
      list.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } else {
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return list;
  }

  void loadTasks() async {
    _isLoading = true;
    notifyListeners();

    final data = box.values.toList();

    _tasks = data.map((e) {
      final map = Map<String, dynamic>.from(e);

      return Task(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        isCompleted: map['isCompleted'] ?? false,
        dueDate: DateTime.parse(map['dueDate']),
        createdAt: DateTime.parse(map['createdAt']),
      );
    }).toList();

    _isLoading = false;
    notifyListeners();
  }

  void setFilter(TaskFilter f) {
    _filter = f;
    notifyListeners();
  }

  void setSort(TaskSort s) {
    _sort = s;
    notifyListeners();
  }

  Future<void> addTask(
      String title,
      String description,
      DateTime dueDate,
      ) async {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      dueDate: dueDate,
      createdAt: DateTime.now(),
    );

    await box.put(task.id, {
      'id': task.id,
      'title': task.title,
      'description': task.description,
      'isCompleted': task.isCompleted,
      'dueDate': task.dueDate.toIso8601String(),
      'createdAt': task.createdAt.toIso8601String(),
    });

    loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await box.delete(id);
    loadTasks();
  }

  Future<void> updateTask(Task t) async {
    await box.put(t.id, {
      'id': t.id,
      'title': t.title,
      'description': t.description,
      'isCompleted': t.isCompleted,
      'dueDate': t.dueDate.toIso8601String(),
      'createdAt': t.createdAt.toIso8601String(),
    });

    loadTasks();
  }

  void toggleComplete(Task t) {
    final updated = t.copyWith(isCompleted: !t.isCompleted);
    updateTask(updated);
  }
}