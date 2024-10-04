import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
              child: Container(
                width: 52,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: selected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceContainer,
                    width: 2,
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.13),
                  //     blurRadius: 4.0,
                  //     offset: const Offset(0, 3),
                  //   ),
                  // ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('EEE').format(date),
                      style: const TextStyle(fontSize: 13),
                    ),
                    Text(
                      date.day.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
