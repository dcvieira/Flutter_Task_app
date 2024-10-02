import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/pages/taskGroup/widgets/task_group_item.dart';
import 'package:todo_app/pages/taskGroupCreate/task_group_create_page.dart';
import 'package:todo_app/pages/taskList/task_list_page.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskGroupListPage extends StatefulWidget {
  const TaskGroupListPage({super.key});

  @override
  State<TaskGroupListPage> createState() => _TaskGroupListPageState();
}

class _TaskGroupListPageState extends State<TaskGroupListPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().fetchTasksGroupWithCounts();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Groups'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          return ListView.builder(
            itemCount: taskProvider.taskGroupsWithCounts.length,
            itemBuilder: (context, index) {
              final taskGroup = taskProvider.taskGroupsWithCounts[index];
              return Dismissible(
                  onDismissed: (direction) async {
                    await context
                        .read<TaskProvider>()
                        .deleteTaskGroup(taskGroup.id);
                  },
                  background: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Delete Task Group',
                          style: TextStyle(
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  key: Key(taskGroup.id),
                  child: TaskGroupItem(taskGroup: taskGroup));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const TaskGroupCreatePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
