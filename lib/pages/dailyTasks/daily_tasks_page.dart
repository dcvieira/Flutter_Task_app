import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/dailyTasks/widgets/daily_task_widget.dart';
import 'package:todo_app/pages/dailyTasks/widgets/task_calendar.dart';
import 'package:todo_app/providers/daily_task_provider.dart';

class DailyTasksPage extends StatefulWidget {
  const DailyTasksPage({super.key});

  @override
  State<DailyTasksPage> createState() => _DailyTasksPageState();
}

class _DailyTasksPageState extends State<DailyTasksPage> {
  DateTime selectedDate = DateTime.now();
  late DailyTaskProvider dailyTaskProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dailyTaskProvider = context.read<DailyTaskProvider>()
        ..fetchDailyTasks(selectedDate);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Tasks'),
      ),
      body: Column(
        children: [
          TaskCalendar(
            selectedDate: selectedDate,
            onDateChanged: (date) {
              dailyTaskProvider.fetchDailyTasks(date);
            },
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
