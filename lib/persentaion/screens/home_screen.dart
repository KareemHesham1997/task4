// ignore_for_file: prefer_const_constructors

import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todoly/data/models/task.dart';
import 'package:todoly/persentaion/screens/done_screen.dart';
import 'package:todoly/persentaion/screens/to_do_screen.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedtasks = 0;
  List<Task> tasks = [
    Task(taskName: "eat breakfast"),
    Task(taskName: "drink cofee"),
    Task(taskName: "morining training"),
    Task(taskName: "Go to Work"),
  ];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //Navigator.of(context).pushNamed(AddTaskScreen.routeName);
            var text = await Navigator.of(context)
                .pushNamed(AddTaskScreen.routeName) as String;
            setState(() {
              tasks.add(Task(taskName: text));
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => SingleChildScrollView(
                  controller: ModalScrollController.of(context),
                ),
              );
            });
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Organize your tasks"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "All Tasks",
              ),
              Tab(
                text: "To DO",
              ),
              Tab(
                text: "Done",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    tasks[index].taskName,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          decoration: tasks[index].isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                  ),
                  trailing: Checkbox(
                    onChanged: (val) {
                      setState(() {
                        tasks[index].isDone = val!;
                        if (tasks[index].isDone) {
                          tasks[index].doneTime = DateTime.now();
                        }
                      });
                    },
                    value: tasks[index].isDone,
                  ),
                );
              },
              itemCount: tasks.length,
            ),
            /* ListView(
              children: tasks
                  .map(
                    (e) => ListTile(
                      title: Text(e.taskName),
                      trailing: Checkbox(
                        onChanged: (val) {
                          setState(() {
                            e.isDone = val!;
                          });
                        },
                        value: e.isDone,
                      ),
                    ),
                  )
                  .toList(),
            ), */
            ToDoScreen(
              tasks: tasks,
            ),
            DoneScreen(
              tasks: tasks,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.list),
                label: "All tasks",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.remove_done),
                label: "To Do",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.done_all),
                label: "Done",
              ),
            ],
            onTap: (currentIndex) {
              setState(() {
                _selectedtasks = currentIndex;
              });
              _tabController.animateTo(_selectedtasks);
            },
            currentIndex: _selectedtasks),
      ),
    );
    /* DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Organize your tasks"),
          bottom: TabBar(
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              Tab(
                child: Text(
                  "All Tasks",
                ),
              ),
              Tab(
                child: Text("ToDo Tasks"),
              ),
              Tab(
                child: Text("Done Tasks"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: tasks
                  .map(
                    (e) => ListTile(
                      title: Text(
                        e.taskName,
                        style: TextStyle(
                          decoration:
                              e.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      trailing: Checkbox(
                        value: e.isDone,
                        onChanged: (bool? value) {
                          setState(() {
                            e.isDone = value!;
                          });
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
            ToDoScreen(),
            DoneScreen(),
          ],
        ),
      ),
    ); */
  }
}
