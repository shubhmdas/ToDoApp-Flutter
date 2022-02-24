import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/database.dart';

class TodoCard extends StatefulWidget {
  final FirebaseFirestore firestore;
  final TodoModel todo;
  final String uid;
  final String status;

  const TodoCard(
      {Key? key,
      required this.firestore,
      required this.todo,
      required this.uid,
      required this.status})
      : super(key: key);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Checkbox(
              fillColor: MaterialStateProperty.all(Colors.grey),
              value: widget.todo.done,
              onChanged: (newValue) async {
                await Database(firestore: widget.firestore).updateTodo(
                    uid: widget.uid,
                    todoId: widget.todo.todoId,
                    value: widget.todo.done);
              },
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.todo.content,
                  style: TextStyle(
                      fontSize: 14,
                      color: widget.status == 'finished'
                          ? Colors.black87
                          : Colors.grey,
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
