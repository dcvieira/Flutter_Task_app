import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key, this.task});
  final Task? task;

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  bool editMode = false;
  String pageTitle = '';

  DateTime? date;

  @override
  void initState() {
    editMode = widget.task != null;
    pageTitle = editMode ? 'Edit Task' : 'New Task';
    if (editMode) {
      titleController.text = widget.task!.title;
      subtitleController.text = widget.task!.subtitle;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTitle(),
              _buildSubtitle(),
              _buildDatePicker(),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () async {
        final isValid = _formKey.currentState!.validate();
        if (isValid) {
          final title = titleController.text;
          final subtitle = subtitleController.text;
          final taskProvider = context.read<TaskProvider>();

          // save task
          if (editMode) {
            final taskForEdit = widget.task!.copyWith(
              title: title,
              subtitle: subtitle,
              date: date,
            );
            await taskProvider.updateTask(taskForEdit);

          } else {
            final newTask = Task.create(title: title, subtitle: subtitle, date: date);
            await taskProvider.addTask(newTask);
          }

          Navigator.of(context).pop();
        }
      },
      child: const Text(
        'Create',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  TextFormField _buildSubtitle() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Subtitle required';
        }
        return null;
      },
      controller: subtitleController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text('Title')),
    );
  }

  TextFormField _buildTitle() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Title required';
        }
        return null;
      },
      controller: titleController,
      maxLines: 6,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text('Title')),
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
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Date'),
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
                    .format(date ?? DateTime.now())
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
