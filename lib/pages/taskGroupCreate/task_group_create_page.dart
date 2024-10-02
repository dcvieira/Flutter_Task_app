import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskGroupCreatePage extends StatefulWidget {
  const TaskGroupCreatePage({super.key});

  @override
  State<TaskGroupCreatePage> createState() => _TaskGroupCreatePageState();
}

class _TaskGroupCreatePageState extends State<TaskGroupCreatePage> {
  final nameController = TextEditingController();
  IconData iconData = Icons.add;
  Color selectedColor = Colors.red;
  final formKey = GlobalKey<FormState>();

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
                _buildIconField(),
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

  Widget _buildIconField() {
    return ListTile(
      title: const Text('Icon'),
      leading: Icon(iconData),
      onTap: () {
        // pickIcon();
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
                    color: color == selectedColor
                        ? Colors.black
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                height: 50,
                width: 50,
                child: color == selectedColor
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

        final taskGroup = TaskGroup.create(
          name: nameController.text,
          icon: iconData.codePoint,
          color: selectedColor.value,
        );

        await context.read<TaskProvider>().createTaskGroup(taskGroup);
        if (mounted) {
          Navigator.of(context).pop();
        }
      },
      child: const Text('Save'),
    );
  }

  // Future<void> pickIcon() async {
  //   final icon = await showIconPicker(
  //     context,
  //     configuration: const SinglePickerConfiguration(
  //       adaptiveDialog: true,
  //     ),
  //   );

  //   if (icon != null) {
  //     setState(() {
  //       iconData = icon.data;
  //     });
  //   }
  // }
}
