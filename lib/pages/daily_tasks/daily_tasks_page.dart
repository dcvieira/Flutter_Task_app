import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/daily_tasks/widgets/daily_task_widget.dart';
import 'package:todo_app/pages/daily_tasks/widgets/daily_tasks_summary_widget.dart';
import 'package:todo_app/pages/daily_tasks/widgets/task_calendar.dart';
import 'package:todo_app/providers/daily_task_provider.dart';

class DailyTasksPage extends StatefulWidget {
  const DailyTasksPage({super.key});

  @override
  State<DailyTasksPage> createState() => _DailyTasksPageState();
}

class _DailyTasksPageState extends State<DailyTasksPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dailyTaskProvider = context.read<DailyTaskProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Tasks'),
        actions: [
          // add a icon to open a caledar to select date
          IconButton(
            onPressed: () async {
              final DateTime? date = await showDatePicker(
                context: context,
                initialDate: dailyTaskProvider.selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                dailyTaskProvider.selectDate(date);
              }
            },
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: Column(
        children: [
          const TaskCalendar(),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: DailyTasksSummaryWidget(),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Divider(
              color: Colors.grey.shade300,
              height: 1,
            ),
          ),
          Expanded(
            child: Consumer<DailyTaskProvider>(builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: provider.tasks.length,
                itemBuilder: (context, index) {
                  return DailyTaskWidget(task: provider.tasks[index]);
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
