import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/pages/daily_tasks/widgets/task_calendar_item.dart';
import 'package:todo_app/providers/daily_task_provider.dart';

class TaskCalendar extends StatelessWidget {
  const TaskCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final dailyTaskProvider = context.watch<DailyTaskProvider>();

    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dailyTaskProvider.datesInMonth.length,
        itemBuilder: (context, index) {
          final date =
              DateUtils.dateOnly(dailyTaskProvider.datesInMonth[index]);
          final selected = date == dailyTaskProvider.selectedDate;
          return GestureDetector(
              onTap: () {
                dailyTaskProvider.selectDate(date);
              },
              child: TaskCalendarItem(date: date, selected: selected));
        },
      ),
    );
  }
}
