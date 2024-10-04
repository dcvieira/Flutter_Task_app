import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/daily_task_provider.dart';

class DailyTasksSummaryWidget extends StatelessWidget {
  const DailyTasksSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dailyTaskProvider = context.watch<DailyTaskProvider>();

    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              backgroundColor: Colors.grey,
              value: dailyTaskProvider.tasks.isNotEmpty
                  ? (dailyTaskProvider.totalTasksDone /
                      dailyTaskProvider.tasks.length)
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
                DateFormat.yMMMEd().format(dailyTaskProvider.selectedDate),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                "${dailyTaskProvider.totalTasksDone} of ${dailyTaskProvider.tasks.length} task",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          )
        ],
      ),
    );
  }
}
