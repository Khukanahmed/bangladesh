import 'package:bangladesh/feature/tasks/controller/tasks_controller.dart';
import 'package:bangladesh/feature/tasks/model/tasks_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksScreen extends StatelessWidget {
  final TasksController controller = Get.put(TasksController());

  TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks Screen')),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            Task task = controller.tasks[index];
            return ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (_) => controller.toggleComplete(task),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      textController.text = task.title;
                      Get.defaultDialog(
                        title: 'Edit Task',
                        content: TextField(controller: textController),
                        textConfirm: "Update Task",
                        onConfirm: () {
                          controller.updateTask(
                            Task(
                              id: task.id,
                              title: textController.text,
                              isCompleted: task.isCompleted,
                              reminder: task.reminder,
                            ),
                          );
                          Get.back();
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => controller.deleteTask(task),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          textController.clear();
          Get.defaultDialog(
            title: 'Add Task',
            content: TextField(controller: textController),
            textConfirm: "Add Task",
            onConfirm: () {
              controller.addTask(
                Task(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: textController.text,
                ),
              );
              Get.back();
            },
          );
        },
      ),
    );
  }
}
