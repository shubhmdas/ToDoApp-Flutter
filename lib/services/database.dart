import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo_model.dart';

class Database {
  late FirebaseFirestore firestore;

  Database({ required this.firestore });

  Stream<List<TodoModel>> streamTodos(String uid) {
    try {
      return firestore.collection('todos').doc(uid)
          .collection('todos')
          .snapshots().map((query) {
        return query.docs.map((DocumentSnapshot doc) {
          return TodoModel.fromDocumentSnapshot(snapshot: doc);
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTodo({ required String uid, required String content }) async {
    try {
      await firestore.collection('todos').doc(uid).collection('todos').add({
        'content': content,
        'done': false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTodo({ required String uid, required String todoId, required bool value }) async {
    try {
      await firestore.collection('todos').doc(uid).collection('todos').doc(todoId).update({
        'done': !value,
      });
    } catch (e) {
      rethrow;
    }
  }
}