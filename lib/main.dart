import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/models/task_group.dart';
import 'package:todo_app/pages/dailyTasks/daily_tasks_page.dart';
import 'package:todo_app/pages/home/home_page.dart';
import 'package:todo_app/pages/taskGroup/task_group_list_page.dart';
import 'package:todo_app/pages/taskList/task_list_page.dart';
import 'package:todo_app/providers/daily_task_provider.dart';
import 'package:todo_app/providers/task_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: '',
    anonKey: '',
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => DailyTaskProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
