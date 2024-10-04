import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key, required this.groupId, this.task});
  final String groupId;
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
  DateTime date = DateTime.now();

  @override
  void initState() {
    editMode = widget.task != null;
    pageTitle = editMode ? 'Edit Task' : 'New Task';
    if (editMode) {
      titleController.text = widget.task!.title;
      subtitleController.text = widget.task!.subtitle;
      date = widget.task!.date;
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
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTitle(),
                const SizedBox(height: 20),
                _buildSubtitle(),
                const SizedBox(height: 20),
                _buildDatePicker(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        onPressed: () async {
          await _submitForm();
        },
        label: editMode ? const Text('Edit Task') : const Text('Add Task'),
        icon: editMode ? const Icon(Icons.edit) : const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  TextFormField _buildSubtitle() {
    return TextFormField(
      validator: (value) {
        if (value != null && value.isNotEmpty && value.length > 50) {
          return 'Title must be less than 25 characters';
        }
        return null;
      },
      maxLines: 3,
      controller: subtitleController,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        label: Text('SubTitle'),
        hintText: 'Enter a description for the task',
        prefixIcon: Icon(Icons.description_outlined),
      ),
    );
  }

  TextFormField _buildTitle() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Title required';
        }
        if (value.length > 25) {
          return 'Title must be less than 25 characters';
        }

        return null;
      },
      controller: titleController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.title),
        border: UnderlineInputBorder(),
        label: Text('Title'),
        hintText: 'Enter a description for the task',
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
        if (selectedDate != null) {
          setState(() {
            date = selectedDate;
          });
        }

        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text('Select a Date'),
            ),
            Expanded(child: Container()),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 140,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: Center(
                child: Text(DateFormat.yMMMEd().format(date).toString()),
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

  Future<void> _submitForm() async {
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
        final newTask = Task.create(
            title: title,
            subtitle: subtitle,
            date: date,
            groupId: widget.groupId);
        await taskProvider.addTask(newTask);
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
