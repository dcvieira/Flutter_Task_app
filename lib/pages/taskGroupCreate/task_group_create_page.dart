import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskGroupCreatePage extends StatefulWidget {
  const TaskGroupCreatePage({super.key, this.taskGroupForEdit});
  final TaskGroup? taskGroupForEdit;

  @override
  State<TaskGroupCreatePage> createState() => _TaskGroupCreatePageState();
}

class _TaskGroupCreatePageState extends State<TaskGroupCreatePage> {
  final nameController = TextEditingController();
  IconData iconData = Icons.add;
  Color selectedColor = Colors.red;
  final formKey = GlobalKey<FormState>();
  bool editMode = false;

  @override
  void initState() {
    editMode = widget.taskGroupForEdit != null;
    if (editMode) {
      final taskGroup = widget.taskGroupForEdit!;
      nameController.text = taskGroup.name;
      selectedColor = Color(taskGroup.color);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Task Group'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _buildNameField(),
                _buildColorField(),
                _buildSaveButton(),
              ],
            ),
          ),
        ));
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
        return null;
      },
    );
  }

  Widget _buildColorField() {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.brown,
      Colors.grey,
    ];
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colors.length,
          itemBuilder: (context, index) {
            final color = colors[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = color;
                });
              },
              child: Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: color.value == selectedColor.value
                        ? Colors.black
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                height: 50,
                width: 50,
                child: color.value == selectedColor.value
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
            );
          }),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        if (!formKey.currentState!.validate()) {
          return;
        }
        final taskProvider = context.read<TaskProvider>();

        if (editMode) {
          final taskGroup = widget.taskGroupForEdit!.copyWith(
            name: nameController.text,
            color: selectedColor.value,
          );

          await taskProvider.updateTaskGroup(taskGroup);
        } else {
          final taskGroup = TaskGroup.create(
            name: nameController.text,
            color: selectedColor.value,
          );

          await taskProvider.createTaskGroup(taskGroup);
        }

        if (mounted) {
          Navigator.of(context).pop();
        }
      },
      child: const Text('Save'),
    );
  }
}
