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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameField(),
                const SizedBox(height: 30),
                Text('Select Color',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                _buildColorField(),
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
        label: editMode
            ? const Text('Edit Task Group')
            : const Text('Add Task Group'),
        icon: editMode ? const Icon(Icons.edit) : const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name is required';
        }
        // max lenth 25
        if (value.length > 25) {
          return 'Name should be less than 25 characters';
        }
        return null;
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.title),
        labelText: 'Name',
        hintText: 'Enter task group name',
      ),
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

  Future<void> _submitForm() async {
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
  }
}
