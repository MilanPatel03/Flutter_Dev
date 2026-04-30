import 'package:flutter/cupertino.dart';

@immutable
// This telling
// flutter that this class should not be changed after creation
class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;
  final DateTime createdAt;

  // THis is Constructor: used when creating a new task object
  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false, //(default value) this means task not done.
    required this.dueDate,
    required this.createdAt,
  });

  // This is Helper method
  // copyWith method: is for//  bby using this for creating NEW TASK Object
  // by modifying only some fields
  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
