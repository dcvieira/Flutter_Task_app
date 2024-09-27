import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/pages/taskCreate/task_create_page.dart';
import 'package:todo_app/providers/daily_task_provider.dart';

class DailyTaskWidget extends StatelessWidget {
  const DailyTaskWidget({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => TaskCreatePage(
                task: task,
              ),
            ),
          );
        },
        leading: GestureDetector(
          onTap: () {
            final newTask = task.copyWith(isCompleted: !task.isCompleted);
            context.read<DailyTaskProvider>().updateTask(newTask);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            decoration: BoxDecoration(
                color: task.isCompleted
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8)),
            child: const Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            // color:
            //     task.isCompleted ? Theme.of(context).primaryColor : Colors.black,
            fontWeight: FontWeight.w500,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.subtitle));
  }
}
