import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  String task;
  String time;
  String date;

  Todo({required this.task,required this.time,required this.date});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: Icon(
          Icons.task,
          color: Colors.blue,
          size: 40.0,
        ),
        title: Text(
          widget.task,
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.time,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              widget.date,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      Divider(
        height: 5.0,
      )
    ]);
  }
}