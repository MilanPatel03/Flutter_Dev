import '../services/task_service.dart';
import '../models/task_model.dart';
import 'task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskService taskService;

  TaskRepositoryImpl({required this.taskService});

  @override
  Future<List<Task>> fetchTasks() => taskService.getTasks();

  @override
  Future<void> addTask(Task task) => taskService.addTask(task);

  @override
  Future<Task?> getTaskById(String id) => taskService.getTask(id);

  @override
  Future<void> updateTask(Task task) => taskService.updateTask(task);

  @override
  Future<void> deleteTask(String id) => taskService.deleteTask(id);
}

// THis repository implements the Actual repository methods with the service class/backend service!