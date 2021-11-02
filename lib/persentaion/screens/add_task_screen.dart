import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  static const String routeName = "/addTask";
  AddTaskScreen({Key? key}) : super(key: key);
  TextEditingController taskNamecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            //Expanded(
            TextField(
              controller: taskNamecontroller,
              // onChanged: (val) {
              //   print(val);
              // },
              //keyboardType: TextInputType.number,
              //enabled: false,
              decoration: InputDecoration(
                hintText: "Enter Task Name",
                label: Text("Task Name"),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                ),
              ),
            ),

            ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  if (taskNamecontroller.text != "") {
                    Navigator.of(context).pop(taskNamecontroller.text);
                  }
                },
                child: Text("Add Task")),
          ],
        ),
      ),
    );
  }
}
