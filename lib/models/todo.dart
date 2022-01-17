import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  late String todoId;
  late String content;
  late bool done;

  TodoModel({ required this.todoId, required this.content, required this.done });

  TodoModel.fromDocumentSnapshot({ required DocumentSnapshot snapshot }) {
    todoId = snapshot.id;
    content = snapshot['content'] as String;
    done = snapshot['done'] as bool;
  }
}