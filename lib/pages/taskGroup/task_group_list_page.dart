import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/pages/taskList/task_list_page.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskGroupListPage extends StatefulWidget {
  const TaskGroupListPage({super.key});

  @override
  State<TaskGroupListPage> createState() => _TaskGroupListPageState();
}

class _TaskGroupListPageState extends State<TaskGroupListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Groups'),
      ),
      body: Consumer<TaskProvider>(builder: (context, taskProvider, _) {
        return ListView.builder(
          itemCount: taskProvider.taskGroupsWithCounts.length,
          itemBuilder: (context, index) {
            final taskGroup = taskProvider.taskGroupsWithCounts[index];
            return ListTile(
              title: Text(taskGroup.name),
              leading: CircleAvatar(
                backgroundColor: Color(taskGroup.color),
                child: Icon(
                  IconData(taskGroup.icon, fontFamily: 'MaterialIcons'),
                  color: Colors.white,
                ),
              ),
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
                    builder: (BuildContext context) => TaskListPage(groupId: taskGroup.id,),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
