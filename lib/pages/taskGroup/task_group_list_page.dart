import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/taskGroup/widgets/task_group_item.dart';
import 'package:todo_app/pages/taskGroupCreate/task_group_create_page.dart';
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
              final taskGroupWithCount =
                  taskProvider.taskGroupsWithCounts[index];
              return Dismissible(
                  onDismissed: (direction) async {
                    await context
                        .read<TaskProvider>()
                        .deleteTaskGroup(taskGroupWithCount.taskGroup.id);
                  },
                  confirmDismiss: (direction) {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Delete Task Group'),
                          content: const Text(
                              'Are you sure you want to delete this task group?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('Delete'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  background: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Delete Task Group',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                  key: Key(taskGroupWithCount.taskGroup.id),
                  child: TaskGroupItem(taskGroupWithCount: taskGroupWithCount));
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
