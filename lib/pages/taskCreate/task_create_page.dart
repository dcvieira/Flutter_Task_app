import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task_model.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key, this.task});
  final Task? task;

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final taskControllerForTitle = TextEditingController();
  final taskControllerForSubtitle = TextEditingController();
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Task"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: taskControllerForTitle,
              maxLines: 6,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            TextFormField(
              controller: taskControllerForSubtitle,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            _buildDatePicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        final selectedDate = await showDatePicker(
            context: context,
            firstDate: DateTime(2000, 3, 5),
            lastDate: DateTime(2030, 3, 5));
        setState(() {
          date = selectedDate;
        });

        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('MyString.dateString'),
            ),
            Expanded(child: Container()),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 140,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100),
              child: Center(
                child: Text(DateFormat.yMMMEd()
                    .format(widget.task?.date ?? DateTime.now())
                    .toString()),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Show Selected Date As DateTime Format
  DateTime showDateAsDateTime(DateTime? date) {
    if (widget.task?.date == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.date;
    }
  }
}
