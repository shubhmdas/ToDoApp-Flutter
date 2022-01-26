import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/database.dart';


class TodoCard extends StatefulWidget {

  final FirebaseFirestore firestore;
  final TodoModel todo;
  final String uid;
  final String item;

  const TodoCard({Key? key,  required this.firestore, required this.todo, required this.uid, required this.item }) : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    late BorderRadius borderRadius;
    if (widget.item == 'first') {
      borderRadius = const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4));
    } else if (widget.item == 'last') {
      borderRadius = const BorderRadius.only(bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4));
    } else {
      borderRadius = BorderRadius.zero;
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Checkbox(
              value: widget.todo.done,
              onChanged: (newValue)async {
                await Database(firestore: widget.firestore).updateTodo(
                    uid: widget.uid, todoId: widget.todo.todoId
                );// setState(() {});
              },
            ),
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
          ],
        ),
      ),
    );
  }
}
