import 'package:flutter/material.dart';
import 'package:todoly/data/models/task.dart';
import 'package:todoly/persentaion/screens/add_task_screen.dart';

import 'done_screen.dart';

class ToDoScreen extends StatelessWidget {
  List<Task> tasks;
  ToDoScreen({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    tasks = tasks.where((element) => element.isDone == false).toList();
    return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].taskName),
          );
        },
        itemCount: tasks.length);
  }
}
