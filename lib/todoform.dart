import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/components.dart';
import 'package:todo/models/tasksmodel.dart';

import 'models/tasksclass.dart';
import 'models/databasefunctions.dart';

class TodoHome extends StatefulWidget {
  TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  var tasknameController = TextEditingController();
  var tasktimeController = TextEditingController();
  var taskdateController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    databasef.createDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextForm(
                        controller: tasknameController,
                        type: TextInputType.text,
                        label: 'Task Name',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'task name must not be empty';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextForm(
                        controller: tasktimeController,
                        type: TextInputType.text,
                        label: 'Task Time',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'task time must not be empty';
                          } else {
                            return null;
                          }
                        },
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) => tasktimeController.text =
                                  value!.format(context).toString());
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextForm(
                        controller: taskdateController,
                        type: TextInputType.text,
                        label: 'Task Date',
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'task date must not be empty';
                          } else {
                            return null;
                          }
                        },
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2022-12-22'),
                          ).then((value) {
                            //package intl
                            taskdateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Button(
                                text: 'Save',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      databasef.insertDb(
                                          task: tasknameController.text,
                                          time: tasktimeController.text,
                                          date: taskdateController.text);

                                      todoist.add(Tasks(
                                          task: tasknameController.text,
                                          time: tasktimeController.text,
                                          date: taskdateController.text));
                                    });
                                  }
                                }),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Card(
              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: ListView.builder(
                itemCount: todoist.length,
                itemBuilder: (context, index) {
                  return Todo(
                      task: todoist[index].task,
                      time: todoist[index].time,
                      date: todoist[index].date);
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}