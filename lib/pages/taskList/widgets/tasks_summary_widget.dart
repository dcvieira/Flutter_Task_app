import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task_provider.dart';

class TasksSummaryWidget extends StatelessWidget {
  const TasksSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();

    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// CircularProgressIndicator
          SizedBox(
            width: 35,
            height: 35,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Tasks',
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
          )
        ],
      ),
    );
  }
}
