import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/database.dart';


class TodoCard extends StatefulWidget {

  final FirebaseFirestore firestore;
  final TodoModel todo;
  final String uid;

  const TodoCard({Key? key,  required this.firestore, required this.todo, required this.uid }) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 2, 2, 2),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.todo.content,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Muli',
                      fontWeight: FontWeight.w200),
                ),
              ),
            ),
            Checkbox(
                value: widget.todo.done,
                onChanged: (newValue)async {
                  await Database(firestore: widget.firestore).updateTodo(
                  uid: widget.uid, todoId: widget.todo.todoId
                  );// setState(() {});
                },
            )
          ],
        ),
      ),
    );
  }
}
