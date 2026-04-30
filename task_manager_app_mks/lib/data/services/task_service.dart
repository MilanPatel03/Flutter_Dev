import 'dart:async';

import '../models/task_model.dart';

class TaskService {
  // Simulating data source, // ye bas ek private list hai (fake database ki tarah)
  // for now only, because Abhi API Data syncing nahi hh, So..
  final List<Task> _tasks = [];

  Future<List<Task>> getTasks() async {
    await Future.delayed(const Duration(milliseconds: 500)); // this represents delay

    return _tasks;
  }

  Future<void> addTask(Task task) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tasks.add(task);
  }

  // Ek task id se lene ke liye
  Future<Task?> getTask(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // same id wale task ka index
    int index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    // purana task replace
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  Future<void> deleteTask(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _tasks.removeWhere((task) => task.id == id);
  }
}

// Ye ek fake backend/service layer hai,
// Aur async use karke real API jaisa behavior diya hai
// UI aur logic ko alag rakhta hai,