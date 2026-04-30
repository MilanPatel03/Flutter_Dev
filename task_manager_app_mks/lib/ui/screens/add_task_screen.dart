import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/task_model.dart';
import '../viewmodels/task_view_model.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/addTask';

  final Task? task;

  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
      selectedDate = widget.task!.dueDate;
    }
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TaskViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Enter title';
                  }
                  return null;
                },
              ),

              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Enter description';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate == null
                        ? 'No date selected'
                        : 'Due: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                  ),
                  ElevatedButton(
                    onPressed: pickDate,
                    child: const Text('Pick Date'),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                child: Text(widget.task == null ? 'Add' : 'Update'),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  if (selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Select date')),
                    );
                    return;
                  }

                  final title = _titleController.text.trim();
                  final desc = _descController.text.trim();

                  if (widget.task == null) {
                    await vm.addTask(title, desc, selectedDate!);
                  } else {
                    final updated = widget.task!.copyWith(
                      title: title,
                      description: desc,
                      dueDate: selectedDate,
                    );

                    await vm.updateTask(updated);
                  }

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}