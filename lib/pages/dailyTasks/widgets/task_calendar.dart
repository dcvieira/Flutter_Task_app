import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCalendar extends StatefulWidget {
  final DateTime selectedDate;
  final Function(DateTime date)? onDateChanged;
  const TaskCalendar(
      {super.key, required this.selectedDate, this.onDateChanged});

  @override
  State<TaskCalendar> createState() => _TaskCalendarState();
}

class _TaskCalendarState extends State<TaskCalendar> {
  late DateTime selectedDate;

  @override
  void initState() {
    selectedDate = widget.selectedDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dates = _getDatesInMonth(selectedDate);
    final selectedDateOnly = DateUtils.dateOnly(selectedDate);

    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dates.length,
          itemBuilder: (context, index) {
            final date = DateUtils.dateOnly(dates[index]);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDate = date;
                });
                widget.onDateChanged?.call(date);
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
                    date == selectedDateOnly
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

  List<DateTime> _getDatesInMonth(DateTime selectedDate) {
    List<DateTime> dates = [];
    DateTime firstDay = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime lastDay = DateTime(selectedDate.year, selectedDate.month + 1, 0);

    for (DateTime date = firstDay;
        date.isBefore(lastDay);
        date = date.add(const Duration(days: 1))) {
      dates.add(date);
    }

    return dates;
  }
}
