import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/pages/taskCreate/task_create_page.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => TaskCreatePage(
              task: task,
              groupId: task.groupId,
            ),
          ),
        );
      },
      leading: GestureDetector(
        onTap: () {
          final newTask = task.copyWith(isCompleted: !task.isCompleted);
          context.read<TaskProvider>().updateTask(newTask);
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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.subtitle,
            // style: TextStyle(
            //   color: task.isCompleted
            //       ? Theme.of(context).colorScheme.primary
            //       : const Color.fromARGB(255, 164, 164, 164),
            //   fontWeight: FontWeight.w300,
            //   decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            // ),
          ),

          /// Date & Time of Task
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
                top: 10,
              ),
              child: Text(
                DateFormat.yMMMEd().format(task.date),
                style: TextStyle(
                  fontSize: 12,
                  color: task.isCompleted ? Colors.white : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
