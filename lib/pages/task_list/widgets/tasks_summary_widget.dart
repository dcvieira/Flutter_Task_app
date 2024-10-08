import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_group_provider.dart';

import 'package:todo_app/providers/task_provider.dart';

class TasksSummaryWidget extends StatelessWidget {
  const TasksSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final taskGroupProvider = context.watch<TaskGroupProvider>();

    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: AlwaysStoppedAnimation(
                  Color(taskGroupProvider.selectedTaskGroup!.color)),
              backgroundColor: Colors.grey,
              value: taskProvider.tasks.isNotEmpty
                  ? (taskProvider.totalTasksDone / taskProvider.tasks.length)
                  : 0,
            ),
          ),
          const SizedBox(
            width: 20,
          ),

          /// Texts
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskGroupProvider.selectedTaskGroup!.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  "${taskProvider.totalTasksDone} of ${taskProvider.tasks.length} task",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
