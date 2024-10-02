import 'package:flutter/material.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/pages/taskList/task_list_page.dart';

class TaskGroupItem extends StatelessWidget {
  const TaskGroupItem({
    super.key,
    required this.taskGroup,
  });

  final TaskGroupWithCounts taskGroup;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskGroup.name,
        style:  const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
      ),
      subtitle: Text(
          '${taskGroup.completedTasks}/${taskGroup.totalTasks} tasks'),
      trailing: CircularProgressIndicator(
        strokeWidth: 5,
        valueColor: AlwaysStoppedAnimation(Color(taskGroup.color)),
        backgroundColor: Colors.grey,
        value: taskGroup.totalTasks > 0
            ? (taskGroup.completedTasks / taskGroup.totalTasks)
            : 0,
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => TaskListPage(
              groupId: taskGroup.id,
            ),
          ),
        );
      },
    );
  }
}
