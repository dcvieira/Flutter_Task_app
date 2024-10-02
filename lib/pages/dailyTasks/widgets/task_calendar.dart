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
            return GestureDetector(
              onTap: () {
                dailyTaskProvider.selectDate(date);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.13),
                      blurRadius: 4.0,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('EEE').format(date),
                    ),
                    date == dailyTaskProvider.selectedDate
                        ? Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Colors.deepPurple,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                date.day.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : Text(date.day.toString()),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
