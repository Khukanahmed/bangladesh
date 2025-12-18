import 'package:bangladesh/feature/tasks/model/tasks_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TasksController extends GetxController {
  var tasks = <Task>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    List? stored = storage.read<List>('tasks');
    if (stored != null) {
      tasks.value = stored.map((e) => Task.fromMap(e)).toList();
    }
  }

  void saveTasks() {
    storage.write('tasks', tasks.map((e) => e.toMap()).toList());
  }

  void addTask(Task task) {
    tasks.add(task);
    saveTasks();
  }

  void updateTask(Task task) {
    int index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      tasks[index] = task;
      saveTasks();
    }
  }

  void deleteTask(Task task) {
    tasks.removeWhere((t) => t.id == task.id);
    saveTasks();
  }

  void toggleComplete(Task task) {
    task.isCompleted = !task.isCompleted;
    updateTask(task);
  }
}
