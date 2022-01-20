import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';

class TodoCard extends StatefulWidget {

  late FirebaseFirestore firestore;
  late TodoModel todo;
  late String uid;

  TodoCard({Key? key,  required this.firestore, required this.todo, required this.uid }) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.todo.content,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.w200),
              ),
            ),
            Checkbox(
                value: widget.todo.done,
                onChanged: (newValue)async {
                  await Database(firestore: widget.firestore).updateTodo(
                  uid: widget.uid, todoId: widget.todo.todoId
                  );
                  // setState(() {});
                },
            )
          ],
        ),
      ),
    );
  }
}
