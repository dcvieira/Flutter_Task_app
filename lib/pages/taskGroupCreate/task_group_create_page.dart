import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class TaskGroupCreatePage extends StatefulWidget {
  const TaskGroupCreatePage({super.key});

  @override
  State<TaskGroupCreatePage> createState() => _TaskGroupCreatePageState();
}

class _TaskGroupCreatePageState extends State<TaskGroupCreatePage> {
  IconData iconData = Icons.add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task Group'),
      ),
      body: Center(
        child: GestureDetector(
            onTap: () async {
              await pickIcon();
            },
            child: Row(
              children: [Text('Create Task Group'), Icon(iconData)],
            )),
      ),
    );
  }

  Future<void> pickIcon() async {
    final icon = await showIconPicker(
      context,
      configuration: const SinglePickerConfiguration(
        adaptiveDialog: true,
      ),
    );

    if (icon != null) {
      setState(() {
        iconData = icon.data;
      });
    }
  }
}
